Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWBRXQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWBRXQk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 18:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWBRXQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 18:16:40 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:45191 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932269AbWBRXQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 18:16:40 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/1] swsusp: fix breakage with swap on LVM
Date: Sun, 19 Feb 2006 00:16:28 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <20060216161300.0C667194045@smtp.etmail.cz> <200602162341.17090.rjw@sisk.pl> <20060218145112.GA5658@openzaurus.ucw.cz>
In-Reply-To: <20060218145112.GA5658@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602190016.28909.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 15:51, Pavel Machek wrote:
> On Thu 16-02-06 23:41:16, Rafael J. Wysocki wrote:
> > On Thursday 16 February 2006 22:51, Rafael J. Wysocki wrote:
> > > On Thursday 16 February 2006 17:13, Pavel Machek wrote:
> > > > -rc3 version looks ok, and we probably want it in asap. -mm
> > > > version looks a bit long... --p
> > > 
> > > That's because it adds a new function + comment.
> > > 
> > > I think it's not a good idea to remake mm/swapfile.c:swap_type_of()
> > > in a -rc3-like fashion, because it is called by the userland interface for
> > > a different purpose and should not return non-error for the argument
> > > being zero.
> > 
> > Well, alternatively I can change the userland interface. :-)
> 
> ACK.

OK

Andrew, could you replace the
swsusp-separate-swap-writing-reading-code-rev-2-fix-breakage-with-swap-on-lvm.patch
with this one, please?  [Appended once again for convenience.]

Rafael
---

Restore the compatibility with the older code and make it possible to
suspend if the kernel command line doesn't contain the "resume=" argument.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 kernel/power/user.c |   13 +++++++++----
 mm/swapfile.c       |    6 ++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

Index: linux-2.6.16-rc3-mm1/mm/swapfile.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/mm/swapfile.c
+++ linux-2.6.16-rc3-mm1/mm/swapfile.c
@@ -428,14 +428,16 @@ int swap_type_of(dev_t device)
 {
 	int i;
 
-	if (!device)
-		return -EINVAL;
 	spin_lock(&swap_lock);
 	for (i = 0; i < nr_swapfiles; i++) {
 		struct inode *inode;
 
 		if (!(swap_info[i].flags & SWP_WRITEOK))
 			continue;
+		if (!device) {
+			spin_unlock(&swap_lock);
+			return i;
+		}
 		inode = swap_info->swap_file->f_dentry->d_inode;
 		if (S_ISBLK(inode->i_mode) &&
 		    device == MKDEV(imajor(inode), iminor(inode))) {
Index: linux-2.6.16-rc3-mm1/kernel/power/user.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/kernel/power/user.c
+++ linux-2.6.16-rc3-mm1/kernel/power/user.c
@@ -51,7 +51,7 @@ static int snapshot_open(struct inode *i
 	filp->private_data = data;
 	memset(&data->handle, 0, sizeof(struct snapshot_handle));
 	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
-		data->swap = swap_type_of(swsusp_resume_device);
+		data->swap = swsusp_resume_device ? swap_type_of(swsusp_resume_device) : -1;
 		data->mode = O_RDONLY;
 	} else {
 		data->swap = -1;
@@ -252,9 +252,14 @@ static int snapshot_ioctl(struct inode *
 			 * User space encodes device types as two-byte values,
 			 * so we need to recode them
 			 */
-			data->swap = swap_type_of(old_decode_dev(arg));
-			if (data->swap < 0)
-				error = -ENODEV;
+			if (old_decode_dev(arg)) {
+				data->swap = swap_type_of(old_decode_dev(arg));
+				if (data->swap < 0)
+					error = -ENODEV;
+			} else {
+				data->swap = -1;
+				error = -EINVAL;
+			}
 		} else {
 			error = -EPERM;
 		}
