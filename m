Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265377AbUFOJDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUFOJDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 05:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUFOJDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 05:03:34 -0400
Received: from web54101.mail.yahoo.com ([206.190.37.236]:13199 "HELO
	web54101.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265377AbUFOJDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 05:03:30 -0400
Message-ID: <20040615090330.81780.qmail@web54101.mail.yahoo.com>
Date: Tue, 15 Jun 2004 02:03:30 -0700 (PDT)
From: Kumar V <vhkumar95@yahoo.com>
Subject: DMA-ACQ-HELP
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I would like to acquire the data through DMA @1kbps
contineously.
I am not able to acquire the data correctly, I am
missing the data.
What would be the reason. From H/W side there is no
problem.
Here Idea is to divide 4k into 128 block of data i.e.
4096/128=32 blocks and I would like to take previously
acquired  
block of data. After 4kb it should roll back to
starting, like circular 
Q.
Here is the driver code for the same.
Please help me what would be the problem.
Thanks in advance.

Regards
V. Kumar.

*********************************

At open entry
dma_buff = __get_dma_pages(__GFP_DMA, 0); //
1-page(4096 byte) 
flags = claim_dma_lock ();
disable_dma (dma_ch);
clear_dma_ff (dma_ch);
set_dma_mode (dma_ch, DMA_MODE_READ | DMA_AUTOINIT);
set_dma_addr (dma_ch, virt_to_bus (dma_buff));
set_dma_count (dma_ch,4096 );
enable_dma (dma_ch);
release_dma_lock (flags);
*******************************

At Read Entry
flags = claim_dma_lock ();
residue = get_dma_residue (dma_ch);

// just to wait for at least 1k bytes to acquire
if (( prev_cntr-residue) < 128 )
{
	prevcntr = residue ;
	return 0 ;
}
prev_cntr = residue ;

i = 4096 - residue;
// Copying the acquired data to tmp buff of 128 bytes
// mean time DMA can continue the data transfer 
start = (int)(i / 128);
start = start * 128;
for (i = 0; i < 128; i++)
	tbuff[i] = dma_buff[start + i];
__copy_to_user ((unsigned char *) buf, (unsigned char
*) tbuff,
         sizeof (tbuff));
*******************************



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - You care about security. So do we.
http://promotions.yahoo.com/new_mail
