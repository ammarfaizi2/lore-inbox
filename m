Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVBJRXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVBJRXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 12:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVBJRXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 12:23:38 -0500
Received: from linux.us.dell.com ([143.166.224.162]:27247 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262165AbVBJRXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 12:23:36 -0500
Date: Thu, 10 Feb 2005 11:23:23 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: EDD failures since edd=off patch
Message-ID: <20050210172323.GA29225@lists.us.dell.com>
References: <420B6BA8.1040808@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420B6BA8.1040808@gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 03:11:52PM +0100, Carl-Daniel Hailfinger wrote:
> Hi Matt,
> 
> it seems the edd=off patch has caused some problems with
> some machines I have access to. They simply don't boot
> anymore unless I specify edd=foo. foo can be {off,skip,bar}
> so it seems the hang on boot is related to the parser
> not finding the parameter it is looking for.
> I looked through the code some days ago and it seemed to
> me that the register used to iterate through the command
> line buffer only got its lower 16 bit reset before calling
> into the BIOS. I don't have the code handy right now,
> but I can look later if the hints I gave are insufficient.

Yes, please.  I'm reading the code, and %ecx gets set to
(COMMAND_LINE_SIZE-7) which is 256-7=249.  So the upper 24 bits of
%ecx are going to always be zero, and if "edd=" isn't seen, then %ecx
will be zero when dropping into edd_mbr_sig_start.  The only other
register touched is %esi, but it's pushed at the beginning, and pop'd
on all exit cases, so that should be unchanged.

ZF is the only other bit I can picture.  On the "no edd= option" path,
ZF=0 on exit.  With "edd=of" or "edd=sk", ZF=1.  But with "edd=bar",
ZF=0, which you say works too.  So that's not it...

CF is taken care of around the int13 calls already, so that's not
it...

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
