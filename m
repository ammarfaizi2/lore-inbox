Return-Path: <linux-kernel-owner+w=401wt.eu-S1752646AbWLSGpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbWLSGpJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbWLSGpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:45:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40213 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646AbWLSGpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:45:07 -0500
Date: Tue, 19 Dec 2006 01:44:54 -0500
From: Dave Jones <davej@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, Chris Rankin <cj.rankin@ntlworld.com>
Subject: Re: -mm merge plans for 2.6.20
Message-ID: <20061219064454.GG31146@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Hugh Dickins <hugh@veritas.com>,
	Chris Rankin <cj.rankin@ntlworld.com>
References: <20061204204024.2401148d.akpm@osdl.org> <20061205160250.GB9076@kernelslacker.org> <20061212174909.GD2140@redhat.com> <458776A5.3060007@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458776A5.3060007@yahoo.com.au>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 04:20:37PM +1100, Nick Piggin wrote:
 > Dave Jones wrote:
 > 
 > > Eeek! page_mapcount(page) went negative! (-2)
 > 
 > Hmm, probably happened once before, too.

You're right. Going back further in the log, I noticed
that it had happened again exactly at the time that cron restarted vpnc.
The first time, the flags were different..

 Dec  4 00:01:03 firewall kernel: Eeek! page_mapcount(page) went negative! (-1)
 Dec  4 00:01:03 firewall kernel:   page->flags = 400
 Dec  4 00:01:03 firewall kernel:   page->count = 1
 Dec  4 00:01:03 firewall kernel:   page->mapping = 00000000

 > >   page->flags = 404
 > 
 > What's that? PG_referenced|PG_reserved? So I'd say it is likely
 > that some driver has got its refcounting wrong.

At the time that it bit me, here's what was loaded..

tun ipt_MASQUERADE iptable_nat ip_nat ipt_LOG xt_limit ipv6
ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp
iptable_filter ip_tables x_tables video sbs i2c_ec button battery asus_acpi ac
parport_pc lp parport pcspkr ide_cd i2c_viapro i2c_core cdrom 3c59x via_rhine
via_ircc mii irda crc_ccitt serio_raw dm_snapshot dm_zero dm_mirror dm_mod ext3
jbd ehci_hcd ohci_hcd uhci_hcd

The scary ones (i2c, irda) weren't in use at all, and had never been opened afaik,
so the potential for those to be corrupting memory is slim, but not out of the
question. (Why the hell asus_acpi is loaded is a mystery, this isn't an Asus,
or a laptop. Probably dumb initscripts).

 > And I see we've got another report for 2.6.19.1 from Chris, which
 > is equally vague.

I'll be moving that box to 2.6.19.x at some point real soon, so I'll holler
if I see it again on a later kernel.

 > IMO the pattern is much too consistent to be able to attribute
 > them all to hardware problems. And considering it takes so long
 > for these things to appear, can we get something like the attached
 > patch upstream at least until we manage to stamp them out?

Sounds like a good idea to me.

ACKed-by: Dave Jones <davej@redhat.com>

 > Any other debugging info we can add?

Would it be useful to print the pfn of the page ?
In cases like mine, where it bit twice before it killed the box, it
might be interesting to see if its always the same page.  Not sure
what that would prove/disprove though.

		Dave

-- 
http://www.codemonkey.org.uk
