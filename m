Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbUKEQp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbUKEQp0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbUKEQpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:45:25 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:38348 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262674AbUKEQpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:45:01 -0500
Date: Fri, 5 Nov 2004 10:44:49 -0600
From: Jack Steiner <steiner@sgi.com>
To: Andreas Schwab <schwab@suse.de>
Cc: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, ak@suse.de,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Externalize SLIT table
Message-ID: <20041105164449.GC26719@sgi.com>
References: <20041103205655.GA5084@sgi.com> <20041104.105908.18574694.t-kochi@bq.jp.nec.com> <20041104040713.GC21211@wotan.suse.de> <20041104.135721.08317994.t-kochi@bq.jp.nec.com> <20041105160808.GA26719@sgi.com> <jevfcknty5.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <jevfcknty5.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 05:26:10PM +0100, Andreas Schwab wrote:
> Jack Steiner <steiner@sgi.com> writes:
> 
> > @@ -111,6 +111,21 @@ static ssize_t node_read_numastat(struct
> >  }
> >  static SYSDEV_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
> >  
> > +static ssize_t node_read_distance(struct sys_device * dev, char * buf)
> > +{
> > +	int nid = dev->id;
> > +	int len = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < numnodes; i++)
> > +		len += sprintf(buf + len, "%s%d", i ? " " : "", node_distance(nid, i));
> 
> Can this overflow the space allocated for buf?


Good point. I think we are ok for now. AFAIK, the largest cpu count
currently supported is 512. That gives a max string of 2k (max of 3 
digits + space per cpu).

However, I should probably add a BUILD_BUG_ON to check for overflow.

	BUILD_BUG_ON(NR_NODES*4 > PAGE_SIZE/2);
	BUILD_BUG_ON(NR_CPUS*4 > PAGE_SIZE/2);



> 
> > @@ -58,6 +59,31 @@ static inline void register_cpu_control(
> >  }
> >  #endif /* CONFIG_HOTPLUG_CPU */
> >  
> > +#ifdef CONFIG_NUMA
> > +static ssize_t cpu_read_distance(struct sys_device * dev, char * buf)
> > +{
> > +	int nid = cpu_to_node(dev->id);
> > +	int len = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < num_possible_cpus(); i++)
> > +		len += sprintf(buf + len, "%s%d", i ? " " : "", 
> > +			node_distance(nid, cpu_to_node(i)));
> 
> Or this?
> 
> Andreas.
> 
> -- 
> Andreas Schwab, SuSE Labs, schwab@suse.de
> SuSE Linux AG, Maxfeldstra_e 5, 90409 N|rnberg, Germany
> Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


