Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUAJPAg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265208AbUAJPAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:00:36 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:34953 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265207AbUAJPAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:00:34 -0500
Message-ID: <4000135C.4060008@BitWagon.com>
Date: Sat, 10 Jan 2004 06:59:40 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2. ELF loader mystery
References: <20040110145329.36ecaa38@argon.inf.tu-dresden.de>
In-Reply-To: <20040110145329.36ecaa38@argon.inf.tu-dresden.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Udo A. Steinberg wrote:
> Linux 2.2 refuses to allocate certain .bss ELF sections in memory if there
> are PT_LOAD sections following them. Is there any convention saying that
> .bss must always be the last section and must not be followed by PT_LOAD
> sections? OTOH both Linux 2.4 and 2.6 have no trouble getting this right
> and load the binary just fine.

Please give the complete kernel version number: 2.2.19, 2.4.23, 2.6.0, etc.
binfmt_elf has had bugs that were introduced/fixed/re-introduced/re-fixed
within the 2.4 series, for example.

Yes, there was an interpretation of ELF that p_filesz < p_memsz implied .bss
only for the last PT_LOAD in the array of Elf32_Phdr.  Later this was changed
so that .bss applied only on the PT_LOAD with the highest p_vaddr, regardless
of position in Elf32_Phdr.  [In your example this accounts for the missing
.bss from 0x000a6468 to 0x000b8818, because the p_paddr is 0x00001000 but
the other p_vaddr is 0x000ba000 which is greater.]  The best interpretation
is that p_filesz < p_memsz implies ".bss" [kernel-supplied, zeroed bytes
and/or pages] separately for _each_ PT_LOAD.

[Note that binfmt_elf ignores Sections.  binfmt_elf pays attention only to
PT_LOAD.  Aggregating from Elf32_Shdr into ELf32_Phdr is the job of /bin/ld.]

-- 
John Reiser, jreiser@BitWagon.com

