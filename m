Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbUK3PgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbUK3PgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbUK3PgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:36:06 -0500
Received: from canuck.infradead.org ([205.233.218.70]:6150 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262098AbUK3Pfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:35:44 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
In-Reply-To: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1101828924.26071.172.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 15:35:24 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 09:41 -0800, Linus Torvalds wrote:
> In fact, in many ways I'd prefer to have source-level annotations like 
> "this is exported to user space" over trying to gather things in one 
> place.

I don't think you would; not once you really tried it. 

That's what the littering of ifdef __KERNEL__ attempts to do, and
there's not really any better way of doing it than that. Whatever form
of annotation you came up with, it wouldn't be much different to using
__KERNEL__ and performing the 'export' step using unifdef. Changing the
sense of it so that we annotate the stuff which _is_ visible rather than
the stuff which _isn't_ doesn't really make it fundamentally different
either.

If we want to make stuff cleaner in userspace that means spreading the
headers much more liberally with such ifdefs or whatever trick we use to
replace them. It gets ugly quite fast -- and we already know that the
fix for having too many ifdefs is to split stuff up more sensibly. 
By splitting the visible parts into separate files we actually help to
make people _think_ when they're exposing stuff to userspace, and it
would help to direct particularly close attention to reviewing
structures therein. For example, if the netfilter people tried to add
this to a header file which is explicitly for userspace consumption,
rather than hidden away in kernel private headers and just _happening_
to be part of the userspace ABI, they'd never get away with it:

struct ipt_rateinfo {
	u_int32_t avg;    /* Average secs between packets * scale */
        u_int32_t burst;  /* Period multiplier for upper limit. */
 
        /* Used internally by the kernel */
        unsigned long prev;
        u_int32_t credit;
        u_int32_t credit_cap, cost;
 
        /* Ugly, ugly fucker. */
        struct ipt_rateinfo *master;
};

Use of an 'unsigned long' which gratuitously changes the structure size
between 32-bit userspace and 64-bit kernel, without even any _reason_
for it being there. That kind of thing would be far more obvious if the
headers are split, and much less so if we continue as we are. 

That and the ugliness of the __KERNEL__ or whatever other annotation
scheme we come up with are the main reasons why I think it wants to be
separate header files for sharing with userspace, rather than continuing
with the mess we have.

Let's go through the kernel headers and identify what actually needs to
be exported; yes. But let's not 'annotate' it and post-process the mess
of header files to sanitise it; let's just take the parts which need to
be shared, put them into different header files and include them from
there.

-- 
dwmw2

