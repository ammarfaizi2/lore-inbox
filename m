Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVCQVmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVCQVmc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 16:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVCQVmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 16:42:32 -0500
Received: from fmr15.intel.com ([192.55.52.69]:19330 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261157AbVCQVm1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 16:42:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Deadlocked kernel when using brw_kiovec to do direct I/O
Date: Thu, 17 Mar 2005 14:42:23 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C206934722@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Deadlocked kernel when using brw_kiovec to do direct I/O
thread-index: AcUrOjQb58T7e7BHTMqpPGAQo5rxPw==
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Mar 2005 21:42:24.0837 (UTC) FILETIME=[35119750:01C52B3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I'm using brw_kiovec() on a 2.4.28 kernel to write directly to a
hard drive from a kernel module that I wrote. I have a 64k buffer that I
pass to brw_kiovec() and it writes the data to the hard drive directly
like it's supposed to. However, I noticed that if I make more than one
call to brw_kiovec() to write more data, the second call will cause the
machine to freeze hard. I have to reboot via the reset button (SysRq
doesn't work). Below is the code from just the part that calls
brw_kiovec() (based on some of the code in the Linux Kernel Crash Dump):

void RC_file_writer(const char *buffer)
{
        int return_value, i;
        unsigned long *b = RC_dump_iobuf->blocks, blocknr, blocks;

        if (RC_dump_offset & (RC_dump_block_size - 1))
        {
                printk(KERN_ERR "RapidCapture: RC_dump_offset wasn't
aligned properly.\n");
                return;
        }

        /* Reset the block number values */
        blocknr = RC_dump_offset >> RC_dump_block_shift;


        /* Calculate the number of blocks */
        blocks = RC_BUFFER_SIZE >> RC_dump_block_shift;
        if (blocks > (KIO_MAX_SECTORS >> (RC_dump_block_shift - 9)))
                blocks = KIO_MAX_SECTORS >> (RC_dump_block_shift - 9);

        /* Map the block numbers */
        for (i = 0; i < blocks; i++)
                b[i] = blocknr++;

        /* Write the data to the raw device bypassing any file caches.
*/
        return_value = brw_kiovec(WRITE, 1, &RC_dump_iobuf,
RC_dump_device, b, RC_dump_block_size);
        if (return_value != RC_BUFFER_SIZE)
                printk(KERN_ERR "RapidCapture: Write was trucated!\n");
        else
                RC_dump_offset += return_value;
}
