Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWFBTlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWFBTlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWFBTlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:41:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:13854 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750810AbWFBTlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:41:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=c51miBoEGuQ8Rth3l7exd2jIlCHQ8UDUcEspSwo6S9zVC67JTMxYVxM/rmi30EJCS9Wlq8gI22ng2qDgDStoij5TfBukMaltSr1cfHF84p7B08zNDBkwPIfp0pABqznnM+fhztQnNcidvmUVVnmQS2SlRR4Hy5850Y9iuoZdtOE=
Message-ID: <fa7d16350606021241v632d0a77l600ffea513cf37b9@mail.gmail.com>
Date: Fri, 2 Jun 2006 15:41:34 -0400
From: Flavio <ff@member.org>
To: linux-kernel@vger.kernel.org
Subject: d_entry delete ( d_delete ) in d_cache.c on linux 2.6.15 and beyond
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: b6c93bf7ca73e64f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I notice that on versions 2.6.15 and later, the function

     void d_delete(struct dentry * dentry)

Implements a mechanism for notifying the deletion of the d_entry.

The implementation assumes that the d_entry has a non-null d_inode pointer
and that seems to be terribly wrong. In other words, how can a
"negative d_entry"
be deleted? Implementation of rename may use dummy dentries (that have d_inode
set to NULL) and that is a problem as well.

Please CC me if you have any comments/feedback on this subject.

Thanks!

-- ff@member.org

PS. For more specific details on the code I'm referring to, see below:

File .../fs/dcache.c

void d_delete(struct dentry * dentry)
{
	int isdir = 0;
...
	spin_lock(&dcache_lock);
	spin_lock(&dentry->d_lock);
	isdir = S_ISDIR(dentry->d_inode->i_mode);   <======= MUST CHECK d_inode!!!!
	if (atomic_read(&dentry->d_count) == 1) {
...
}
