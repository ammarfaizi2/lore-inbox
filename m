Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbUCOX1s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbUCOX1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:27:38 -0500
Received: from limicola.its.UU.SE ([130.238.7.33]:32492 "EHLO
	limicola.its.uu.se") by vger.kernel.org with ESMTP id S262948AbUCOXZ5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:25:57 -0500
Message-Id: <200403152325.i2FNPNnG006936@Tempo.Update.UU.SE>
To: linux-kernel@vger.kernel.org
Subject: Re: strange ext3 corruption problem on 2.6.x
References: <1zRh6-2V6-9@gated-at.bofh.it> <1zRh6-2V6-7@gated-at.bofh.it>
From: Thorild Selen <thorild@Update.UU.SE>
Date: Tue, 16 Mar 2004 00:25:20 +0100
In-Reply-To: <1zRh6-2V6-7@gated-at.bofh.it> (Marc Lehmann's message of "Mon,
 15 Mar 2004 04:50:08 +0100")
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Lehmann <pcg@schmorp.de> writes:

> On Mon, Mar 15, 2004 at 08:59:29AM +1030, jpearson@oasissystems.com.au wrote:
>> 'r/o' by the RAID layer, presumably unbeknownst to VFS; are you
>> *sure* that your array is still up and 'good' when you get this
>> message?
>
> As I said, there are no other messages, so if there is a problem (cabling,
> disk-i/o etc.), then the kernel doesn't know it either (usually the kernel
> it quite loud in this condition).

I was able to repeat this (although with a somewhat different error
message) on a Xeon machine (HT, so "almost" SMP) running 2.6.3 (with
some IPv6 and NFS related patches, most likely nothing affecting
LVM/md/ext3). It took a few hours running bonnie++ on an ext3 fs on
LVM atop raid5 (four Hitachi SATA disks on a Promise SATA150 TX4
controller) until the machine got problems.

The kernel log says:

  Mar 15 06:34:40 Psilocybe kernel: EXT3-fs error (device dm-2):
    ext3_readdir: bad entry in directory #11: rec_len %% 4 != 0 - off
    set=0, inode=1061109567, rec_len=16191, name_len=63
  Mar 15 06:34:40 Psilocybe kernel: Aborting journal on device dm-2.
  Mar 15 06:34:40 Psilocybe kernel: EXT3-fs error (device dm-2) in
    ext3_ordered_writepage: IO failure
  Mar 15 06:34:40 Psilocybe kernel: EXT3-fs error (device dm-2) in
    ext3_ordered_writepage: IO failure
  Mar 15 06:34:41 Psilocybe kernel: ext3_abort called.
  Mar 15 06:34:41 Psilocybe kernel: EXT3-fs abort (device dm-2):
    ext3_journal_start: Detected aborted journal
  Mar 15 06:34:41 Psilocybe kernel: Remounting filesystem read-only
  Mar 15 06:34:42 Psilocybe kernel: EXT3-fs error (device dm-2) in
    start_transaction: Journal has aborted

And the last words from bonnie++ were:

  Writing intelligently...Can't write block.
  Bonnie: drastic I/O error (write(2)): No such file or directory

Then bonnie exited. It seems like something unrelated to this fs was
in an inconsistent state at this stage, as the machine crashed some
hours later.

The last syslog entry before the crash was at 11:05:01, then the
machine crashed quietly. The console was blank; the machine still
responded to pings, but appeared otherwise dead. The arrays were not
clean and were reconstructed at boot, also arrays that were not
involved in running the benchmark.

I can try to repeat the experiment with another fs if that is desired,
but people seem to agree already that the problem is in ext3. Any
suggestions on how to continue?


Thorild Selén
Datorföreningen Update / Update Computer Club, Uppsala, SE
