Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUDBMIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 07:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbUDBMIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 07:08:04 -0500
Received: from mailout.zma.compaq.com ([161.114.64.105]:55568 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S263460AbUDBMH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 07:07:58 -0500
Date: Fri, 2 Apr 2004 14:07:12 +0200
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: benh@kernel.crashing.org, trini@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: 40x PPC relocation issue during boot
Message-ID: <20040402120712.GF1756@tmathiasen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-OS: Linux 2.6.5-rc3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the current 2.6 tree, there's an issue when one tries to boot a
zImage image (with or without an attached initrd). This is present in the -benh
tree as well.

In ~/arch/ppc/boot/simple/relocate.S the following snip is present:

..
	li	r9,0xc
	mtlr	r9
#ifdef CONFIG_PPC_MULTIPLATFORM
	/* tell kernel we're prep, by putting 0xdeadc0de at KERNELLOAD,
	 * and tell the kernel to start on the 4th instruction since we
	 * overwrite the first 3 sometimes (which are 'nop').
	 */
	lis	r10,0xdeadc0de@h
	ori	r10,r10,0xdeadc0de@l
	li	r9,0
	stw	r10,0(r9)
#endif
	blr


We jump to the 4th instruction, but for the 40x class of cpu's this inst being
taken into account anymore. 3 nop's are missing from head_4xx.S:

	.text
_GLOBAL(_stext)
_GLOBAL(_start)

	/* Save parameters we are passed.
	*/
	mr	r31,r3
	mr	r30,r4
	...
	...

The requirements of the 3 nops is silly anyway, but the relocation code needs
to be fixed. I haven't done the patch as I'm not sure if any other code will
overwrite the first 3 instructions. I hit this bug on an IBM 405EP dev
platform.

Torben
- 
