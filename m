Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262095AbSJNTDJ>; Mon, 14 Oct 2002 15:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262102AbSJNTDJ>; Mon, 14 Oct 2002 15:03:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23964 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262095AbSJNTDI>;
	Mon, 14 Oct 2002 15:03:08 -0400
Date: Mon, 14 Oct 2002 12:02:00 -0700 (PDT)
Message-Id: <20021014.120200.77420883.davem@redhat.com>
To: bart.de.schuymer@pandora.be
Cc: linux-kernel@vger.kernel.org, buytenh@gnu.org, rusty@rustcorp.com.au
Subject: Re: [RFC] bridge-nf -- map IPv4 hooks onto bridge hooks, vs 2.5.42
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210142058.53355.bart.de.schuymer@pandora.be>
References: <200210142005.06292.bart.de.schuymer@pandora.be>
	<20021014.110159.15420052.davem@redhat.com>
	<200210142058.53355.bart.de.schuymer@pandora.be>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bart De Schuymer <bart.de.schuymer@pandora.be>
   Date: Mon, 14 Oct 2002 20:58:53 +0200

   Can the bridge code go fill in a skb->dst and skb->dst->hh? Is this
   considered clean?
   
If it is a properly formed 'dst' entry, it will get cleaned up
at SKB free and there will be no problems.

   > 3) The bridging layer changes need to be approved by Lennert.
   >    But I'd suggest working out #1 and #2 first.
   
   So if I change
   struct nf_conntrack {

You shouldn't be touching nf_conntrack, you should perhaps
instead do something like:

struct nf_ct_info {
	union {
		struct nf_conntrack *master;
		struct nf_bridge_info *brinfo;
	} u;
};
   
But again, you need to get these sorts of extensions and core
changes approved by the netfilter team.

I'm the wrong person to ask about how they would prefer this
stuff be done.

   So if you want this in the kernel you'll have to be forgiving. Or
   present a nice solution, because I and probably Lennert really
   don't see a nice(r) solution.
   
It is my job to show you why a piece of code isn't going
to go in.  It is not my job to help you dream up a better
solution.

Because, frankly I don't care about bridge netfiltering.

I do care about keeping the code as clean as possible so I don't
run into road blocks when trying to rework input/output processing
just because I let some bogon hack into the tree I must continue to
support.

You do care about bridge netfiltering, so you are going to be the
one to find the clean solution that doesn't touch net/ipv4/*.c :-)

This is life in the kernel hacking community :-)

   So, the best solution I can think of is adding a skbuff->brnf pointer to a 
   struct brnf_data. This will get rid of the copy in ip_output.c. Is that 
   enough? This will uglify the ip_tables.c patch however.
   
That could work too, I think you'll need to specify a seperate
destructor in that case, and all this stuff ifdef'd on whether
bridge netfiltering is enabled or not.

Again, talk to the netfilter folks.  They may even have ideas
for you that you haven't dreamt of yet.

Franks a lot,
David S. Miller
davem@redhat.com
