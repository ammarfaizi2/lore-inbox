Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUBCNf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 08:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUBCNf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 08:35:56 -0500
Received: from users.linvision.com ([62.58.92.114]:42681 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S266003AbUBCNfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 08:35:53 -0500
Date: Tue, 3 Feb 2004 14:35:51 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: "P. Christeas" <p_christ@hol.gr>
Cc: lkml <linux-kernel@vger.kernel.org>, viro@math.psu.edu
Subject: Re: Q: large files in iso9660 ?
Message-ID: <20040203133551.GA11957@bitwizard.nl>
References: <200402020024.31785.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402020024.31785.p_christ@hol.gr>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 12:24:31AM +0200, P. Christeas wrote:
> I've tried to create a disk (DVD) which contains a single 3.8GB file. The 
> creation (mkisofs) worked and the disk's TOC reads 3.8GB.

No, it didn't. Last time I tried mkisofs warned about files being
larger than 2GB. Feel free to ignore the warnings, though.

> However, the 
> filesystem reads as if one ~9MB file only exists. 
> I guess large files in isofs may be out of spec. 
> 
> Q: What's the file size limit in iso9660?

About 2GB.

> Q: Is there any chance the negative number (although out of spec) may be 
> correctly interpreted (mount option) ?

The kernel (2.6 and 2.4) has the following code in isofs_read_inode():

        /*
         * The ISO-9660 filesystem only stores 32 bits for file size.
         * mkisofs handles files up to 2GB-2 = 2147483646 = 0x7FFFFFFE bytes
         * in size. This is according to the large file summit paper from 1996.
         * WARNING: ISO-9660 filesystems > 1 GB and even > 2 GB are fully
         *          legal. Do not prevent to use DVD's schilling@fokus.gmd.de
         */
        if ((inode->i_size < 0 || inode->i_size > 0x7FFFFFFE) &&
            sbi->s_cruft == 'n') {
                printk(KERN_WARNING "Warning: defective CD-ROM.  "
                       "Enabling \"cruft\" mount option.\n");
                sbi->s_cruft = 'y';
        }

IOW: your kernel should have warned you about the defective CDROM and
truncated filesizes to 16MB (which is what the "cruft" mount option
does).


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
