Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUHSHRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUHSHRA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUHSHRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:17:00 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:41931 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262328AbUHSHQy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 03:16:54 -0400
Message-ID: <412453E3.30003@free.fr>
Date: Thu, 19 Aug 2004 09:16:51 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: len.brown@intel.com, zhenyu.z.wang@intel.com,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, linux@brodo.de,
       linux-kernel@vger.kernel.org, shaohua.li@intel.com
Subject: Re: 2.6.8.1-mm1 and Asus L3C : problematic change found, can be reverted.
 Real fix still missing
References: <41189098.4000400@free.fr> <4118A500.1080306@free.fr> <20040810090743.3fa75a74.akpm@osdl.org> <4123AC79.5000709@free.fr> <20040819000045.GA9079@hell.org.pl>
In-Reply-To: <20040819000045.GA9079@hell.org.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karol Kozimor wrote:
> Okay, so I think I've finally got what's happening here.
> Enabling the SMBus device (00:1f.3) seems to mess up the resource
> reservation code, specifically the 0xe800 port region. Here's the diff
> between 2.6.8.1-mm1 acpi=off and the same kernel with no arguments:

Hi Karol,

This is the same problem on every asus motherboard including very old 
ones like my A7V : the ACPI pre-allocates the ioport region for the SMB 
bus because the DTSD contain indication to do so and special care should 
be used in order to reuse the IO port range already owned by ACPI 
(motherboard).

See :
<http://lkml.org/lkml/2004/8/3/160>

And especially the end of /proc/oprots current one (before ACPI fix, I 
was forced to avoid/not fail ioport reservation for SMB in i2c-viapro.c)

e800-e80f : 0000:00:04.4	<===============
    e800-e80f : motherboard

But with the shaohua li proposed fix for 
<http://bugme.osdl.org/show_bug.cgi?id=3049>, i2c-viapro.c becomes owner 
of part of this ioport range:

e800-e80f : 0000:00:04.4
   e800-e80f : motherboard
     e800-e807 : viapro-smbus    <========

So in other words, it is possible either to force reallocation of an 
ioport range already owned by ACPI now (at least in some configuration) 
or to avoid this io port allocation has it is already mapped like my 
proposed kludge to make A7V work...

However :
	1) I have no clue however of the correct way to do this,
	2) I do not know if the fix for 
<http://bugme.osdl.org/show_bug.cgi?id=3049> is also valid for this ASUS 
motherboard/laptop,
	3) I still would like to know what you want to do with the SMB bus...

-- eric




