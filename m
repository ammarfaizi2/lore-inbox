Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129191AbRBCDtH>; Fri, 2 Feb 2001 22:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129814AbRBCDsw>; Fri, 2 Feb 2001 22:48:52 -0500
Received: from corp.commerceflow.com ([208.185.105.100]:61169 "EHLO
	mail.commerceflow.com") by vger.kernel.org with ESMTP
	id <S129144AbRBCDsc>; Fri, 2 Feb 2001 22:48:32 -0500
Message-ID: <3A7B7F8C.67C2B603@commerceflow.com>
Date: Fri, 02 Feb 2001 19:48:28 -0800
From: Jeffrey Keller <jeff@commerceflow.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Reasons to honor readonly mount requests
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04 2001 at 17:49:46 EST, Stephen C. Tweedie wrote:

> I will be adding support for virtual replay for root filesystems to 
> act as a last-chance way of recovering if you really cannot write to 
> the root, but journaling filesystems really do expect to be able to 
> write to the media so I am not sure whether it makes sense to support 
> this on non-root filesystems too. 
> ...
> A root fs readonly mount is usually designed to prevent 
> the filesystem from being stomped on during the initial boot so that 
> fsck can run without the filesystem being volatile. That's the only 
> reason for the readonly mount: to allow recovery before we enable 
> writes. With ext3, that recovery is done in the kernel, so doing that 
> recovery during mount makes perfect sense even if the user is mounting 
> root readonly. 

Apologies for a belated follow-up, but the coverage of this thread in
Kernel Traffic caught my eye.  I understand that both ext3fs and
reiserfs will try to fix corrupt filesystems (or at least filesystems
with unprocessed log entries) in-place even if they're mounted
read-only.  Clearly, virtual replay means more work, but -- just for
fun -- here are some cases in which it might matter:

1. You want the disk image untouched for forensic analysis or data
   recovery.
2. You don't trust the disk to do writes properly.
3. You don't trust the driver to do writes properly.
4. You want to test a newer or unstable FS implementation w/ option to
   go back to the older one.
5. You're sharing the disk via:
        VMWare (multiple OS instances on 1 computer)
        passive backplane (multiple computers on 1 bus)
        PCI bridge (multiple computers w/ connected buses)
        SCSI/FC/FireWire (multiple computers sharing device)

The merit of #5 is reduced but not quite obviated by the fact that
it's generally unsafe to share a disk if even one party is writing to
it.  (It might barely be possible do safe one-writer/many-reader disk
sharing using a phase-tree-like FS, but as interesting projects go, it
probably rivals heterogeneous SMP in perversity.)

Come to think of it, you could probably use loopback to insulate the
disk from writes in all these cases.  Hmm.

Please CC me on any follow-ups.
--Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
