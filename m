Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVCHTOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVCHTOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVCHTOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:14:05 -0500
Received: from isilmar.linta.de ([213.239.214.66]:46040 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261561AbVCHTLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:11:39 -0500
Date: Tue, 8 Mar 2005 20:11:38 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
       jt@hpl.hp.com
Subject: PCMCIA product id strings -> hashes generation at compilation time? [Was: Re: [patch 14/38] pcmcia: id_table for wavelan_cs]
Message-ID: <20050308191138.GA16169@isilmar.linta.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
	jt@hpl.hp.com
References: <20050227161308.GO7351@dominikbrodowski.de> <20050307225355.GB30371@bougret.hpl.hp.com> <20050307230102.GA29779@isilmar.linta.de> <20050307150957.0456dd75.akpm@osdl.org> <20050307232339.GA30057@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307232339.GA30057@isilmar.linta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Linus, all,

[note: for detailed code please take a look at 2.6.11-mm2]

Most pcmcia devices are matched to drivers using "product ID strings"
embedded in the devices' Card Information Structures, as "manufactor ID /
card ID" matches are much less reliable. Unfortunately, these strings cannot
be passed to userspace for easy userspace-based loading of appropriate
modules (MODNAME -- hotplug), so my suggestion is to also store crc32 hashes
of the strings in the MODULE_DEVICE_TABLEs, e.g.:

PCMCIA_DEVICE_PROD_ID12("LINKSYS", "E-CARD", 0xf7cb0b07, 0x6701da11),

Only the hashes are stored in "modules.alias", and only the hashes
calculated upon device insertion are passed to userspace.

While having to determine the crc32 hashes is a hassle to device driver 
authors, I do not see a smart way to generate these (or similar) hashes 
automatically at compilation time:
	- the C preprocessor doesn't seem to be smart enough
	- scripts/mod/file2alias.c would need to learn all architectures
	  (and be cross-compilation aware) to relocate/dereference/access
	  strings saved as         
		const char *          prod_id[4];
	  in struct pcmcia_device_id s

To make the life easier for device driver authors,
	- a big warning is put into dmesg if a pcmcia driver is inserted
	  into the kernel and the hash mentioned in PCMCIA_DEVICE_PROD_ID()
	  is incorrect,
	- the hash can easily be calculated in userspace from existing
	  /etc/pcmcia/config files, from inserted PCMCIA cards and and and...,
	- I've added the appropriate hashes for all device matches for 
	  drivers in the base linux kernel.

Even though I'm a bit uncomfortable with this solution, I do not see any
other feasible way. Linus, Andrew, do you agree with this handling despite
all the troubles involved with it? 

	Dominik
