Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbWIWBRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbWIWBRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 21:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWIWBRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 21:17:19 -0400
Received: from xenotime.net ([66.160.160.81]:7133 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965084AbWIWBRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 21:17:18 -0400
Date: Fri, 22 Sep 2006 18:18:26 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Message-Id: <20060922181826.3b209d1d.rdunlap@xenotime.net>
In-Reply-To: <200609230218.36894.arnd@arndb.de>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	<200609230218.36894.arnd@arndb.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 02:18:36 +0200 Arnd Bergmann wrote:

> I've done a brief review. Overall, it looks fine, but you have lots of
> code duplication between your specific machines. It would be good
> to generalize that further.

Yes, I noticed that too.


> It would be good if you can get your code to build cleanly when using
> C=1 with sparse, right now that clearly won't work.

See Documentation/SubmitChecklist.

> Detailed comments follow
> 
> > +/*#define IRQ_DEBUG*/
> > +#undef IRQ_DEBUG
> > +
> > +#ifdef IRQ_DEBUG
> > +#define IRQ_DPRINTK(x...)	printk(x)
> > +#else
> > +#define IRQ_DPRINTK(x...)	do { } while (0)
> > +#endif
> 
> Use pr_debug here instead of making up your own macros

I saw 3 versions/variants of debug printk macros.  :(
(maybe I missed a few :)

[lots of other good comments snipped :]


> > +static char *cplb_print_entry(char *buf, int type)
> > +{
> > +	unsigned long *p_addr = dpdt_table;
> > +	unsigned long *p_data = dpdt_table + 1;
> > +	unsigned long *p_icount = dpdt_swapcount_table;
> > +	unsigned long *p_ocount = dpdt_swapcount_table + 1;
> > +	unsigned long *cplb_addr = (unsigned long *)DCPLB_ADDR0;
> > +	unsigned long *cplb_data = (unsigned long *)DCPLB_DATA0;
> > +	int entry, used_cplb = 0;
> > +
> > +	if (type == CPLB_I) {
> > +		buf += sprintf(buf, "Instrction CPLB entry:\n");
> > +		p_addr = ipdt_table;
> > +		p_data = ipdt_table + 1;
> > +		p_icount = ipdt_swapcount_table;
> > +		p_ocount = ipdt_swapcount_table + 1;
> > +		cplb_addr = (unsigned long *)ICPLB_ADDR0;
> > +		cplb_data = (unsigned long *)ICPLB_DATA0;
> > +	} else
> > +		buf += sprintf(buf, "Data CPLB entry:\n");
> > +
> > +	buf += sprintf(buf, "Address\t\tData\tSize\tValid\tLocked\tSwapin\
> > +\tiCount\toCount\n");
> > +
> > +	while (*p_addr != 0xffffffff) {
> > +		entry = cplb_find_entry(cplb_addr, cplb_data, *p_addr);
> > +		if (entry >= 0 && *p_data == cplb_data[entry])
> > +			used_cplb |= 1 << entry;
> > +
> > +		buf +=
> > +		    sprintf(buf,
> > +			    "0x%08lx\t0x%05lx\t%s\t%c\t%c\t%2d\t%ld\t%ld\n",
> > +			    *p_addr, *p_data,
> > +			    page_size_string_table[(*p_data & 0x30000) >> 16],
> > +			    (*p_data & CPLB_VALID) ? 'Y' : 'N',
> > +			    (*p_data & CPLB_LOCK) ? 'Y' : 'N', entry, *p_icount,
> > +			    *p_ocount);
> > +
> > +		p_addr += 2;
> > +		p_data += 2;
> > +		p_icount += 2;
> > +		p_ocount += 2;
> > +	}
> > +
> > +	if (used_cplb != 0xffff) {
> > +		buf += sprintf(buf, "Unused/mismatched CPLBs:\n");
> > +
> > +		for (entry = 0; entry < 16; entry++)
> > +			if (0 == ((1 << entry) & used_cplb)) {
> > +				int flags = cplb_data[entry];
> > +				buf +=
> > +				    sprintf(buf,
> > +					    "%2d: 0x%08lx\t0x%05x\t%s\t%c\t%c\n",
> > +					    entry, cplb_addr[entry], flags,
> > +					    page_size_string_table[(flags &
> > +								    0x30000) >>
> > +								   16],
> > +					    (flags & CPLB_VALID) ? 'Y' : 'N',
> > +					    (flags & CPLB_LOCK) ? 'Y' : 'N');
> > +			}
> > +	}
> > +
> > +	buf += sprintf(buf, "\n");
> > +
> > +	return buf;
> > +}
> 
> Another one of those files that just don't belong in procfs. Find some other
> interface for this.

examples of acceptable interfaces?

---
~Randy
