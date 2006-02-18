Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWBRMO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWBRMO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWBRMO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:14:57 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:15373 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751163AbWBRMO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:14:56 -0500
Date: Sat, 18 Feb 2006 13:14:14 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>, rusty@rustcorp.com.au
Cc: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org
Subject: Re: kbuild: Section mismatch warnings
Message-ID: <20060218121414.GA5273@mars.ravnborg.org>
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <200602171949.27532.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602171949.27532.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 07:49:26PM -0500, Dmitry Torokhov wrote:
> On Friday 17 February 2006 17:47, Sam Ravnborg wrote:
> > Several warnings are refereces to module parameters - sound/oss/mad16.o
> > as the most visible one. I have not yet figured out if this is a false
> > positive or not. Removing __initdata on the moduleparam variable solves
> > it, but then this may be the wrong approach.
> > 
> 
> It looks like your check does not like when data associated with a module
> parameter is marked __initdata. But I think it is allowed as long as
> module parameter access mode is 0 so we don't create sysfs entry for it. 

It hits only arrays - so I took a look into moduleparam.h.
Looks like an __initdata tag is missing?

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index b5c98c4..e67eafd 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -147,6 +147,7 @@ extern int param_get_invbool(char *buffe
 /* Comma-separated array: *nump is set to number they actually specified. */
 #define module_param_array_named(name, array, type, nump, perm)		\
 	static struct kparam_array __param_arr_##name			\
+	__initdata							\
 	= { ARRAY_SIZE(array), nump, param_set_##type, param_get_##type,\
 	    sizeof(array[0]), array };					\
 	module_param_call(name, param_array_set, param_array_get, 	\


With this change static struct kparam_array __param_arr_##name is placed
in .init.data.
This made the warnings in drivers/input/joystick/db9 disappear.

And with db9 marked __initdata there should be nothing wrong in
using __initdata for __param_arr_##name as I see it.

Rusty - any comments on this?

	Sam
