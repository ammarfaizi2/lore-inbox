Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWFARUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWFARUf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWFARUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:20:35 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:16362 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S964948AbWFARUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:20:34 -0400
Subject: Re: 2.6.17-rc5-mm2
From: Arjan van de Ven <arjan@linux.intel.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0606010851n75b49d83u9f43136b3108886c@mail.gmail.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <6bffcb0e0606010851n75b49d83u9f43136b3108886c@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Jun 2006 19:20:08 +0200
Message-Id: <1149182408.3115.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 17:51 +0200, Michal Piotrowski wrote:
> Hi,
> 
> On 01/06/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> >
> 
> I don't know why, but first bug appears only when avahi-daemon is
> started. Second look like a problem with my camera.
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_1.jpg
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_2.jpg
> 
> Here is config http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/mm-config


can you confirm this fixes it ?

---
 drivers/usb/core/inode.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.17-rc5-mm1.5/drivers/usb/core/inode.c
===================================================================
--- linux-2.6.17-rc5-mm1.5.orig/drivers/usb/core/inode.c
+++ linux-2.6.17-rc5-mm1.5/drivers/usb/core/inode.c
@@ -333,7 +333,7 @@ static int usbfs_empty (struct dentry *d
 static int usbfs_unlink (struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_CHILD);
 	dentry->d_inode->i_nlink--;
 	dput(dentry);
 	mutex_unlock(&inode->i_mutex);
@@ -346,7 +346,7 @@ static int usbfs_rmdir(struct inode *dir
 	int error = -ENOTEMPTY;
 	struct inode * inode = dentry->d_inode;
 
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_CHILD);
 	dentry_unhash(dentry);
 	if (usbfs_empty(dentry)) {
 		dentry->d_inode->i_nlink -= 2;
@@ -528,7 +528,7 @@ static void fs_remove_file (struct dentr
 	if (!parent || !parent->d_inode)
 		return;
 
-	mutex_lock(&parent->d_inode->i_mutex);
+	mutex_lock_nested(&parent->d_inode->i_mutex, I_MUTEX_PARENT);
 	if (usbfs_positive(dentry)) {
 		if (dentry->d_inode) {
 			if (S_ISDIR(dentry->d_inode->i_mode))

