Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289597AbSAONk7>; Tue, 15 Jan 2002 08:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289582AbSAONkk>; Tue, 15 Jan 2002 08:40:40 -0500
Received: from penguin.roanoke.edu ([199.111.154.8]:61710 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S289549AbSAONkX>; Tue, 15 Jan 2002 08:40:23 -0500
Message-ID: <3C44313F.5050406@roanoke.edu>
Date: Tue, 15 Jan 2002 08:40:15 -0500
From: "David L. Parsley" <parsley@roanoke.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Hans-Peter Jansen <hpj@urpla.net>
CC: Neil Brown <neilb@cse.unsw.edu.au>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] symlink problem with knfsd and reiserfs
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm, this sounds a lot like a problem I've been having as well.  Server 
is 2.2.19 (RedHat) + reiserfs; client is 2.4.12.  There are times when I 
mv the contents of public_html to a new location, then rm -rf 
public_html, then make public_html a symlink to the new location.  On 
the client, I think what I would get is an I/O error when trying to list 
or cd to public_html.  On the server everything is fine, and the only 
fix for this I've found is rebooting the client.  The original 
public_html directory is on a knfsd exported reiserfs fs.

Hopefully this is informative; the bug has only bitten me 2 or 3 times 
in several months, and I've not been able to reproduce it at will. :-\

regards,
	David

Hans-Peter Jansen wrote:

> Hi Neil et al.,
> 
> during the last days, Trond and me was able to hunt a problem down
> to $subject, which happens as follows:
> 
> It occurs with all 2.4 kernels, I've tested so far, but for reference:
> 
> Server: 2.4.18-pre3 on Dual P3/500 exports reiserfs partitions
> Client: Diskless 2.4.18-pre3 on Athlon 1.2 GHz
> 
> When building lm_sensors-2.6.2 on the client, I could easily reproduce
> this:
> 
> gcc -shared -Wl,-soname,libsensors.so.1 -o lib/libsensors.so.1.2.0 
> lib/data.lo lib/general.lo lib/error.lo lib/chips.lo lib/proc.lo 
> lib/access.lo lib/init.lo lib/conf-parse.lo lib/conf-lex.lo -lc
> rm -f lib/libsensors.so.1
> ln -sfn libsensors.so.1.2.0 lib/libsensors.so.1
> make: stat:lib/libsensors.so.1: Eingabe-/Ausgabefehler
> rm -f lib/libsensors.so 
> ln -sfn libsensors.so.1.2.0 lib/libsensors.so
> 
> In syslog, this message appears:
> Jan 15 00:21:03 elfe kernel: nfs_refresh_inode: inode 50066 mode changed, 
> 0100664 to 0120777
> 
> In this case, ln managed to create an invalid link in the above sequence.
> Really bad is, you cannot get around this within the client. Within the
> server, the link is ok, but on the client, ls -l lib throws a 
> ls: lib/libsensors.so.1: Eingabe-/Ausgabefehler
> 
> A comment from Trond << EOC
> It is telling you that the server has a blatant bug: it is first
> telling the client that the inode 50066 is a regular file, then
> it changes it to a link.
> 
> When this happens, the RFCs state that the server is supposed to
> change the NFS filehandle. The client *does* check the filehandle, so
> if the server had updated it correctly, you would not have had a
> problem.
> EOC
> 
> A least, Trond was able to get me around it with this patch, but
> I would be nice to fix the real problem instead (b/c the build 
> feels noticable slower with it):
> 
> --- linux-2.4.18-up/fs/nfs/dir.c.orig   Fri Jan 11 23:06:38 2002
> +++ linux-2.4.18-up/fs/nfs/dir.c        Mon Jan 14 23:52:17 2002
> @@ -619,6 +619,8 @@
>                 nfs_complete_unlink(dentry);
>                 unlock_kernel();
>         }
> +       if (is_bad_inode(inode))
> +               force_delete(inode);
>         iput(inode);
>  }
>  
> --- linux-2.4.18-up/fs/nfs/inode.c.orig Fri Jan 11 23:08:00 2002
> +++ linux-2.4.18-up/fs/nfs/inode.c      Mon Jan 14 23:53:10 2002
> @@ -699,6 +699,8 @@
>                 return 0;
>         if (memcmp(&inode->u.nfs_i.fh, fh, sizeof(inode->u.nfs_i.fh)) != 0)
>                 return 0;
> +       if (is_bad_inode(inode))
> +               return 0;
>         /* Force an attribute cache update if inode->i_count == 0 */
>         if (!atomic_read(&inode->i_count))
>                 NFS_CACHEINV(inode);
> 
> An noted, this is a longer standing problem here, but with libsensors build,
> I could easily reproduce this. Do yoou?
> 
> Any chance to get this fixed soon?
> 
> Cheers,
>   Hans-Peter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
David L. Parsley
Network Administrator, Roanoke College
"If I have seen further it is by standing on ye shoulders of Giants."
--Isaac Newton

