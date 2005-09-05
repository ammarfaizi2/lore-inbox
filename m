Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVIERxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVIERxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 13:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVIERxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 13:53:32 -0400
Received: from dhcp-57-63.dsl.telerama.com ([205.201.57.63]:44161 "EHLO
	localhost") by vger.kernel.org with ESMTP id S932362AbVIERxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 13:53:31 -0400
Date: Mon, 5 Sep 2005 13:53:22 -0400 (EDT)
From: Chaskiel Grundman <cg2v@andrew.cmu.edu>
X-X-Sender: cg2v@localhost
To: linux-kernel@vger.kernel.org
Subject: (alpha) process_reloc_for_got confuses r_offset and r_addend
Message-ID: <Pine.LNX.4.63.0509051334440.8784@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/alpha/kernel/module.c:process_reloc_for_got(), which figures out how 
big the .got section for a module should be, appears to be confusing 
r_offset (the file offset that the relocation needs to be applied to) with 
r_addend (the offset of the relocation's actual target address from the 
address of the relocation's symbol). Because of this, one .got entry is 
allocated for each relocation instead of one each unique symbol/addend.

In the module I am working with, this causes the .got section to be almost 
10 times larger than it needs to be (75544 bytes instead of 7608 bytes). 
As the .got is accessed with global-pointer-relative instructions, it 
needs to be within the 64k gp "zone", and a 75544 byte .got clearly does 
not fit. The result of this is that relocation overflows are detected 
during module load and the load is aborted.

Does anyone see anything wrong with this analysis? I tested a patch that 
makes the obvious change to struct got_entry/process_reloc_for_got and it 
seems to work ok.

(Please cc me on replies. thanks)
