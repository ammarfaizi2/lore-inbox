Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264687AbUEMUne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264687AbUEMUne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbUEMUnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 16:43:33 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:39593 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264687AbUEMUn2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 16:43:28 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: alexeyk@mysql.com, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20040511141717.719f3ac8.akpm@osdl.org>
References: <200405022357.59415.alexeyk@mysql.com>
	 <200405050301.32355.alexeyk@mysql.com>
	 <20040504162037.6deccda4.akpm@osdl.org>
	 <200405060204.51591.alexeyk@mysql.com>
	 <20040506014307.1a97d23b.akpm@osdl.org>
	 <1084218659.6140.459.camel@localhost.localdomain>
	 <20040510132151.238b8d0c.akpm@osdl.org>
	 <1084228767.6140.832.camel@localhost.localdomain>
	 <20040510160740.5db8c62c.akpm@osdl.org>
	 <1084308706.25954.28.camel@localhost.localdomain>
	 <20040511141717.719f3ac8.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1084480888.22208.26.camel@dyn319386.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 May 2004 13:41:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 14:17, Andrew Morton wrote:
> Ram Pai <linuxram@us.ibm.com> wrote:
 
I am yet to get my machine fully set up to run a DSS benchmark. But
thought I will update you on the following comment.
 
> 
> multiline comment layout:
> 
> 		/*
> 		 * To avoid rounding errors, ensure that 'average' tends
> 		 * towards the value of ra->serial_cnt.
> 		 */
> 
> (I said "minor").
> 
> I can't say that I immediately understand what is the issue here with
> rounding errors?

Say the i/o size is 20 pages.

Our algorithm starts by a initial average i/o size of 'ra_pages/2' which
is mostly say 16.

Now every time we take a average, the 'average' progresses as follows
(16+20)/2=18
(18+20)/2=19
(19+20)/2=19
(19+20)/2=19.....
and the rounding error makes it never touch 20

However the code can be further optimized to :

 		/* 
                 * to avoid rounding errors, ensure that 'average' 
                 * tends towards the value of ra->serial_cnt.
                 */
                if (ra->average < ra->serial_cnt) {
                        average = ra->average + 1;
                }

I will send a updated patch with all your comments incorporated as soon
as I see good benchmark numbers.(probably by tomorrow).

RP






> 
> 
> > +                if(ra->average > ra->serial_cnt) {
> 
> space between "if" and "("
> 
> > +			ra->next_size = (ra->average > max ?  
> > +				max : ra->average); 
> 
> 	min(max, ra->average) ?
> 
> 
> 

