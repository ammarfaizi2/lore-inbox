Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVKSXbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVKSXbE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 18:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVKSXbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 18:31:04 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:5742 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1751049AbVKSXbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 18:31:02 -0500
Message-ID: <437FB53D.6070709@samwel.tk>
Date: Sun, 20 Nov 2005 00:29:01 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Jan Niehusmann <jan@gondor.com>
CC: linux-kernel@vger.kernel.org, Zhu Yi <yi.zhu@intel.com>,
       Bradley Chapman <kakadu@gmail.com>
Subject: Re: Laptop mode causing writes to wrong sectors?
References: <20051116181612.GA9231@knautsch.gondor.com> <20051117223340.GD14597@elf.ucw.cz> <437E215E.30500@tmr.com> <20051118232019.GA2359@spitz.ucw.cz> <437EE4B3.2090408@samwel.tk> <20051119140527.GA4725@knautsch.gondor.com> <20051119153024.GB4725@knautsch.gondor.com>
In-Reply-To: <20051119153024.GB4725@knautsch.gondor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann wrote:
> Question is, could this bug cause filesystem corruption without any Oops
> visible in the kernel log? Cc: to Zhu Yi at Intel - can you answer this
> question?

OK, can this bug overwrite a page containing filesystem metadata? The 
way it looks to me, it can: it writes at some fixed distance after a 
block of memory allocated by the driver, and that memory could probably 
be anything.

Now, can the stuff go to disk without oopsing? In the case of ext3, the 
metadata writeback is handled by the JBD layer, which is block-based and 
doesn't care about the actual page contents AFAIK -- that's handled by 
the ext3 filesystem layer. That means a corrupted metadata page can go 
to disk without oopsing. Youch. :/

Remaining issue: this bug is only triggered when the ipw2200 driver does 
firmware restarts, which generates kernel output "ipw2200: Firmware 
error detected.  Restarting". Jan, Bradley, do you see any of these 
messages in your logs near the time of corruption? That should be within 
10 minutes before it; the corruption may happen anywhere during a 
spun-down period. (Or does the ipw2200 driver only show this message in 
debug mode?)

--Bart
