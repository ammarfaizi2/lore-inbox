Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbUJ1AF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbUJ1AF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbUJ1AEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:04:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33442 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262684AbUJ0Tpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:45:40 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16767.64161.361255.512272@segfault.boston.redhat.com>
Date: Wed, 27 Oct 2004 15:44:33 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netpoll_setup questions
In-Reply-To: <20041027194113.GP31237@waste.org>
References: <16767.50093.59665.83462@segfault.boston.redhat.com>
	<20041027173031.GO31237@waste.org>
	<16767.61372.910664.763968@segfault.boston.redhat.com>
	<20041027194113.GP31237@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: netpoll_setup questions; Matt Mackall <mpm@selenic.com> adds:

mpm> On Wed, Oct 27, 2004 at 02:58:04PM -0400, Jeff Moyer wrote:
>> ==> Regarding Re: netpoll_setup questions; Matt Mackall
>> <mpm@selenic.com> adds:
>> 
mpm> On Wed, Oct 27, 2004 at 11:50:05AM -0400, Jeff Moyer wrote:
>> >> Hi, Matt,
>> >> 
>> >> The section of code in the body of this if statement:
>> >> 
>> >> if (!(ndev->flags & IFF_UP)) {
>> >> 
>> >> is a bit broken.  First, upon discussion with jgarzik, it seems we >>
>> should not check for IFF_UP, but instead do netif_running.
>> 
mpm> Well I cribbed it from the nfsroot code, which is perhaps not up on
mpm> fashion.
>> Hmm, I can't seem to find the relevant code.  Where is it?

mpm> net/ipv4/ipconfig.c, IIRC.
 
mpm> I don't expect it does. Usually we have our own IP address from the
mpm> command line, but if we don't, we will check if there's an in_dev
mpm> connected to the device and if so, look up the device's IP. This is
mpm> useful for the modular case where the network is up before we start
mpm> and we have a handy default for local IP.
>> Right, but the case in question is the one where we don't have a local
>> IP
specified>

mpm> Yeah..
 
>> if (!np->local_ip) {

mpm> "but if we don't"

>> rcu_read_lock(); in_dev = __in_dev_get(ndev);
>> 
>> if (!in_dev) {

mpm> "we will check if there's an in_dev"

>> rcu_read_unlock(); printk(KERN_ERR "%s: no IP address for %s,
>> aborting\n",
np-> name, np->dev_name);
>> goto release; }
>> 
np-> local_ip = ntohl(in_dev->ifa_list->ifa_local);

mpm> "if so, look up the device's IP"

>> rcu_read_unlock(); printk(KERN_INFO "%s: local IP %d.%d.%d.%d\n",
np-> name, HIPQUAD(np->local_ip));
>> }
>> 
>> 
>> >> And, in the case where it doesn't, you will get an oops further on
>> when >> dereferencing the ifa_list.
>> 
mpm> Does this actually happen? I'm checking in_dev for null already, but
mpm> perhaps I need to check ifa_list as well.
>> Yes, that should do it.

mpm> Again, does the oops actually happen? I'd expect I'd have seen it by
mpm> now if this were really a problem, but I don't mind adding another
mpm> check.

I'm sorry, I should have said this before.  Yes, it occurs.  You simply
need to have an interface in the down state, plugged into a network that
will not auto-assign an address.  Then, modprobe netconsole, and don't
specify what the local IP address is.  Believe it or not, I have a bug
filed on this.  ;)

-Jeff
