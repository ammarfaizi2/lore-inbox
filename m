Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUHMMCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUHMMCi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUHMMCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:02:38 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:60545 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264299AbUHMMCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:02:25 -0400
Date: Fri, 13 Aug 2004 14:03:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "David N. Welton" <davidw@eidetix.com>
Cc: Sascha Wilde <wilde@sha-bang.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
Message-ID: <20040813120357.GA907@ucw.cz>
References: <20040811141408.17933.qmail@web81304.mail.yahoo.com> <20040811175613.GA829@kenny.sha-bang.local> <411BA214.2060306@eidetix.com> <20040812201344.GA270@ucw.cz> <411C944A.3040907@eidetix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411C944A.3040907@eidetix.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 12:13:30PM +0200, David N. Welton wrote:

> Oh, yep, there we go... that's what's switching it around.
> 
> >So I think what happens is that the controller sets the AUXDATA bit for
> >some reason (or at least we read a status byte with the AUXDATA bit
> >set), which negates the value when we read the initial CTR. 
> 
> >Then when we write that nonsensical CTR back to the controller on
> >reboot, we're screwed, since the i8042 is the more important CPU in the
> >system and can do many nasty things to it. ;)
> 
> >Now, the question is, where does that AUXDATA bit come from?
> 
> I noticed that the FreeBSD folks attempt to flush both kbd and aux:
> 
> http://fxr.watson.org/fxr/source/dev/kbd/atkbdc.c#L790
> 
> I tried doing that like so:
> 
> 	while ((i8042_read_status() & (I8042_STR_OBF | I8042_STR_AUXDATA)) 
> 	&& (i++ < I8042_BUFFER_SIZE)) {
> 		data = i8042_read_data();
> 		dbg("%02x <- i8042 (flush, %s)", data,
> 			i8042_read_status() & I8042_STR_AUXDATA ? "aux" : 
> 			"kbd");
> 	}
> 
> with different variations, and it seems as if it will go on reading 
> forever if you let it.  So it keeps reporting AUXDATA as being 
> present...  Hrm...

There is only one queue in the i8042, shared for KBD and AUX. To see if
any data is present, you check the I8042_STR_IBF bit. The
I8042_STR_AUXDATA bit then says which device the data came from.

You can't choose which device you want to read from.

Now I think the problem lies in that that on your i8042 issuing a
command doesn't clear the AUXDATA bit. It's only cleared by data from
the keyboard.

This is likely a bug in you i8042 firmware (or hw, if it's just an
ASIC).

I suppose we can get rid of the checking of data source and negation and
be done with it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
