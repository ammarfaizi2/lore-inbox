Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWFHB2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWFHB2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 21:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWFHB2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 21:28:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35003 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932279AbWFHB2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 21:28:21 -0400
Date: Wed, 7 Jun 2006 18:28:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: paulkf@microgate.com, jeff@garzik.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
Message-Id: <20060607182808.a230e5ee.akpm@osdl.org>
In-Reply-To: <44877659.2020103@microgate.com>
References: <1149694978.12920.14.camel@amdx2.microgate.com>
	<20060607230202.GA12210@havoc.gtf.org>
	<44876D59.1000509@microgate.com>
	<44877659.2020103@microgate.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 19:59:05 -0500
Paul Fulghum <paulkf@microgate.com> wrote:

> Andrew:
> 
> Maybe you can lend some insight on what I should do.
> 
> I have posted multiple, working patches to correct
> the build errors resultsing from random kernel configs.
> 
> But we appear to be in perpetual micromanagement by committee
> mode where different people are giving conflicting
> feedback of the "that's ugly" or "you shouldn't do that" kind.
> 
> I'm happy to accept any *patch* anyone wants to post
> that corrects the build errors *and* does not break
> the driver by removing the ability to optionally include
> generic HDLC support in the synclink drivers *and*
> is accepted by everyone here. Nothing that meets
> those requirements has been posted yet.
> 
> (Randy's last patch comes as close as my last patch, but
> Jeff says any code using conditional configuration is wrong
> so that removes any patch posted so far)
> 
> I'm also happy to accept the status quo, the
> driver works fine.
> 
> So where do we go from here?

Well your patch looked reasonable, except it muddies the CONFIG_foo
namespace.  So could you rework it thusly:


- Change all instances of

#ifdef CONFIG_HDLC
	<stuff>
#endif

to

#ifdef HDLC_ENABLED
	<stuff>
#endif


then do

#if defined(CONFIG_HDLC) || (defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINK_MODULE))
#define HDLC_ENABLED
#endif

or whatever?



Or, better, (but semi off-topic):


#if HDLC_ENABLED
	<stuff>
#endif

#if defined(CONFIG_HDLC) || (defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINK_MODULE))
#define HDLC_ENABLED 1
#else
#define HDLC_ENABLED 0
#endif

Because then a) you'll get a warning if someone already defined
HDLC_ENABLED and b) you'll get a warning if you mistype `#if HLDC_ENABLED'
