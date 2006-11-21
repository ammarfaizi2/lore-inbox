Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030915AbWKUMnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030915AbWKUMnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 07:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030917AbWKUMnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 07:43:49 -0500
Received: from nz-out-0102.google.com ([64.233.162.193]:25292 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030915AbWKUMnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 07:43:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=e6cGdPNNK0yQSQvaVRHoeoNG1N6urAo6hIXNOTUtreKlNhI1Rv8WlMtUC46Q/KJn+7Jn9F9PVu/QIMibz6ERFWtj6yjTQSHQ8CE6cYW2WqN6u+9GwccRZSrBSAmIZYcHCqEYWpNwaetGpx2MT/XrAp1fbI3uRwPdG0j/Y2EMqt4=
Message-ID: <9a8748490611210443w7711b962u3fb35aef14746582@mail.gmail.com>
Date: Tue, 21 Nov 2006 13:43:43 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: [NFS] 2.6.17.8 - do_vfs_lock: VFS is out of sync with lock manager!
Cc: "Neil Brown" <neilb@suse.de>, nfs@lists.sourceforge.net,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1156190098.6158.109.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11969_4530314.1164113023165"
References: <9a8748490608080739w2e14e5ceg44a7bf0a3b475704@mail.gmail.com>
	 <17636.4462.975774.528003@cse.unsw.edu.au>
	 <9a8748490608170258s32df0272r60c8c540e5871485@mail.gmail.com>
	 <17641.10665.116168.867041@cse.unsw.edu.au>
	 <1156190098.6158.109.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_11969_4530314.1164113023165
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 21/08/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Mon, 2006-08-21 at 13:34 +1000, Neil Brown wrote:
> > Looking in fs/nfs/file.c (at 2.6.18-rc4-mm1 if it matters, but 2.6.17
> > is much the same)
> >
> >  - do_vfs_lock is only called when the filesystem was mounted with
> >     -o nolock  EXCEPT
> >  - If a lock request to the server in interrupted (when mounted with
> >      -o intr) then do_vfs_lock is called to try to get the lock
> >     locally.  Normally equivalent code will be called inside
> >     fs/lockd/clntproc.c when the server replies that the lock has been
> >     gained.  In the case of an interrupt though this doesn't happen
> >     but the lock may still have happened on the server.  So we record
> >     locally that the lock was gained, to ensure that it gets unlocked
> >     when the process exits.
> >
> > As you don't have '-o nolocks' you must be hitting the second case.
> > The lock call to the server returns -EINTR or -ERESTARTSYS and
> > do_vfs_lock is called just-in-case.
> > As this is a just-in-case call, it is quite possible that the lock is
> > held by some other process, so getting an error is entirely possible.
> > So printing the message in this case seems wrong.
> >
> > On the other hand, printing the message in any other case seems wrong
> > too, as server locking is not being used, so there is nothing to get
> > out of sync with.
> >
> > As a further complication, I don't think that in the just-in-case
> > situation that it should risk waiting for the lock.
> > Now maybe we can be sure there is a pending signal which will break
> > out of any wait (though I'm worried about -ERESTARTSYS - that doesn't
> > imply a signal does it?), but I would feel more comfortable if
> > FL_SLEEP were turned off in that path.
> >
> > So: Trond:  Any obvious errors in the above?
> > Is the following patch ok?
>
> Could we instead replace it with a dprintk() that returns the value of
> "res"? That will keep it useful for debugging purposes.
>

How about the below?
(compile tested only)

Neil: I left your Signed-off-by line since I just modified your patch slightly.

Since Gmail will probably mangle the inline patch, it is attached as well.


Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
--

 fs/nfs/file.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index cc93865..22572af 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -428,8 +428,8 @@ static int do_vfs_lock(struct file *file
                        BUG();
        }
        if (res < 0)
-               printk(KERN_WARNING "%s: VFS is out of sync with lock
manager!\n",
-                               __FUNCTION__);
+               dprintk("%s: VFS is out of sync with lock manager (res
= %d)!\n",
+                               __FUNCTION__, res);
        return res;
 }

@@ -479,10 +479,13 @@ static int do_setlk(struct file *filp, i
                 * we clean up any state on the server. We therefore
                 * record the lock call as having succeeded in order to
                 * ensure that locks_remove_posix() cleans it out when
-                * the process exits.
+                * the process exits. Make sure not to sleep if
+                * someone else holds the lock.
                 */
-               if (status == -EINTR || status == -ERESTARTSYS)
+               if (status == -EINTR || status == -ERESTARTSYS) {
+                       fl->fl_flags &= ~FL_SLEEP;
                        do_vfs_lock(filp, fl);
+               }
        } else
                status = do_vfs_lock(filp, fl);
        unlock_kernel();



-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_11969_4530314.1164113023165
Content-Type: text/x-patch; name=VFS_is_out_of_sync_with_lock_manager.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eusar882
Content-Disposition: attachment; filename="VFS_is_out_of_sync_with_lock_manager.diff"

ClNpZ25lZC1vZmYtYnk6IE5laWwgQnJvd24gPG5laWxiQHN1c2UuZGU+ClNpZ25lZC1vZmYtYnk6
IEplc3BlciBKdWhsIDxqZXNwZXIuanVobEBnbWFpbC5jb20+Ci0tIAoKIGZzL25mcy9maWxlLmMg
fCAgIDExICsrKysrKystLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9uZnMvZmlsZS5jIGIvZnMvbmZzL2ZpbGUuYwpp
bmRleCBjYzkzODY1Li4yMjU3MmFmIDEwMDY0NAotLS0gYS9mcy9uZnMvZmlsZS5jCisrKyBiL2Zz
L25mcy9maWxlLmMKQEAgLTQyOCw4ICs0MjgsOCBAQCBzdGF0aWMgaW50IGRvX3Zmc19sb2NrKHN0
cnVjdCBmaWxlICpmaWxlCiAJCQlCVUcoKTsKIAl9CiAJaWYgKHJlcyA8IDApCi0JCXByaW50ayhL
RVJOX1dBUk5JTkcgIiVzOiBWRlMgaXMgb3V0IG9mIHN5bmMgd2l0aCBsb2NrIG1hbmFnZXIhXG4i
LAotCQkJCV9fRlVOQ1RJT05fXyk7CisJCWRwcmludGsoIiVzOiBWRlMgaXMgb3V0IG9mIHN5bmMg
d2l0aCBsb2NrIG1hbmFnZXIgKHJlcyA9ICVkKSFcbiIsCisJCQkJX19GVU5DVElPTl9fLCByZXMp
OwogCXJldHVybiByZXM7CiB9CiAKQEAgLTQ3OSwxMCArNDc5LDEzIEBAIHN0YXRpYyBpbnQgZG9f
c2V0bGsoc3RydWN0IGZpbGUgKmZpbHAsIGkKIAkJICogd2UgY2xlYW4gdXAgYW55IHN0YXRlIG9u
IHRoZSBzZXJ2ZXIuIFdlIHRoZXJlZm9yZQogCQkgKiByZWNvcmQgdGhlIGxvY2sgY2FsbCBhcyBo
YXZpbmcgc3VjY2VlZGVkIGluIG9yZGVyIHRvCiAJCSAqIGVuc3VyZSB0aGF0IGxvY2tzX3JlbW92
ZV9wb3NpeCgpIGNsZWFucyBpdCBvdXQgd2hlbgotCQkgKiB0aGUgcHJvY2VzcyBleGl0cy4KKwkJ
ICogdGhlIHByb2Nlc3MgZXhpdHMuIE1ha2Ugc3VyZSBub3QgdG8gc2xlZXAgaWYKKwkJICogc29t
ZW9uZSBlbHNlIGhvbGRzIHRoZSBsb2NrLgogCQkgKi8KLQkJaWYgKHN0YXR1cyA9PSAtRUlOVFIg
fHwgc3RhdHVzID09IC1FUkVTVEFSVFNZUykKKwkJaWYgKHN0YXR1cyA9PSAtRUlOVFIgfHwgc3Rh
dHVzID09IC1FUkVTVEFSVFNZUykgeworCQkJZmwtPmZsX2ZsYWdzICY9IH5GTF9TTEVFUDsKIAkJ
CWRvX3Zmc19sb2NrKGZpbHAsIGZsKTsKKwkJfQogCX0gZWxzZQogCQlzdGF0dXMgPSBkb192ZnNf
bG9jayhmaWxwLCBmbCk7CiAJdW5sb2NrX2tlcm5lbCgpOwoK
------=_Part_11969_4530314.1164113023165--
