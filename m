Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbTG1K3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 06:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTG1K3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 06:29:11 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:776 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S263990AbTG1K27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 06:28:59 -0400
Message-ID: <200307281243530385.12D80171@192.168.128.16>
In-Reply-To: <20030727183547.784b6ab5.davem@redhat.com>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
 <200307280140470646.1078EC67@192.168.128.16>
 <20030727164649.517b2b88.davem@redhat.com>
 <200307280158250677.10891156@192.168.128.16>
 <20030727165831.05904792.davem@redhat.com>
 <200307280211590888.10957DD9@192.168.128.16>
 <20030727171403.6e5bcc58.davem@redhat.com>
 <200307280235210263.10AADFF8@192.168.128.16>
 <20030727173600.475d95fb.davem@redhat.com>
 <200307280253090799.10BB2DF0@192.168.128.16>
 <20030727175557.1d624b36.davem@redhat.com>
 <200307280323020667.10D68954@192.168.128.16>
 <20030727183547.784b6ab5.davem@redhat.com>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Mon, 28 Jul 2003 12:43:53 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2003 at 18:35 David S. Miller wrote:

>I don't deny that it fixes your problem, that is not what
>we're talking about.  We're talking about how one should
>fix the problem, and I'm trying to show you why "hidden"
>patch is not the answer to that.

Yes, and I'm trying to tell you that it's not the only way to solve it,
but it is the simpliest way to do it. As I'm sure most of linux users
that have steped into this "behaviour" think about it.

>Ummm, with "hidden" you still have to make a configuration change.

Just enabling it in the /proc switch.
It could be done "by default" but as we talked about it in the netdev
list, changing the default behaviour of linux when it has been working
this way for years is not a good thing.

>Second of all, "hidden" makes the kernel behave in a non-RFC compliant
>way.  This is the categorization that I use to determine if something
>belongs on the netfilter level or not.

Non-RFC compliant? What RFC is breaking?
I don't think the hidden breaks any RFC, aso I don't think the actual
behaviour breaks any RFC, but if it would do, it would be the actual
one.
The actual behaviour of linux makes loopback interfaces no sense.
Also, as long as I know, 127.0.0.1 is not answered in ARP, although
it's the default address of lo interface. So... there's some filter in
the kernel too.

>If something changes the way in which the Linux networking
>behaves wrt. RFCs, this "operation" belongs at the netfilter level.

I think you are wrong, RFCs do not say anything about interfaces. It's
decission of the OS how this is to be implemented.

>This is true for the "hidden" patch.  It causes the system to
>ignore ARP requests it should respond to.

Not at all, it ignore ARP requests coming from an interface and with
destination the IP address of OTHER interface.
If there's something wrong, I think this is the wrong behaviour.
If we go back to my "problem" setting, linux is doing an ARP request
putting in the src IP addreess, the address of the loopback interface,
that has no sense on the ethernet inteface, causing Cisco to not reply
to this packet (although I think Cisco is failing RFC).

>On the other hand, the "arpfilter" sysctl setting makes the kernel
>still behave in an RFC compliant manner, it only responds to ARPs
>on interfaces it would use to speak to the requestor.

I think the hidden patch is also RFC compliant.
More, the "hidden" patch makes Linux behave like other OS and systems I
have tested.
So... you say all these systems are NOT RFC compliant?

>> Really, the only one I have tested that not do it is Linux 2.2+
>
>Yes, we removed "hidden" from 2.2.x in lieu of "arpfilter" sysctl
>and the netfilter ARP filtering module.

Being the hidden patch the simpliest approach to solve of these
"problems".

>> For me (not a kernel developer), my world are the OSI layers,
>
>OSI layers have nothing to do with the problem we are discussing.
>
>BTW, OSI layers are how networking stacks are described in textbooks
>and standards and far away from how one should implement said stack.
>Van Jacobson even said this once :-)

As long as I know, the hidden patch does isolation of interfaces at
layer 2 (ARP).
About isolation of interfaces at layer 3, the forwarding switch in
/proc should be used.

About the kenel is not the right place to do these things, there are
switchs:
proxy_arp
rp_filter
accept_redirects
forwarding
send_redirects

These example switchs modify the behaviour of the linux box in the
kernel, without using netfilter.

>> I will look... but doing arp filter is not a real simple solution in
>> any way.
>
>It would be really nice if people might consider that it could even be
>possible to make things like the IPVS layer install the appropriate
>NETFILTER_ARP chain rules when the IPVS configuration installed
dictates
>that one is needed.
>
>People using IPVS wouldn't even need to do _ANYTHING_ if IPVS were
>to do that.
>
>And all of that would be _FINE_ because like ARP netfilter, IPVS lies
>inside of netfilter where such things which change networking behavior
>semantics radically belong.

I'm not sure, but IPVS is the Linux Virtual Server?
Well... my "problem" setting was not with LVS, I use a Cisco hardware
load balancing device.
Also, the problem in this setting is not in the load balancing device,
it's on the "real servers" that does not use the LVS software at all.
Just these servers don't know they are being "balanced".

But again, David, LVS is not the only setting that reveal this
"problem" with interface isolation. Bas has stepped into the same
"problem" in another setting.

Also, this "problem" with linux open a minor security hole (see Bas
mail), unless you use ARP filter or hidden patch.

Regards,
Carlos Velasco


