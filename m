Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262141AbSJNTvu>; Mon, 14 Oct 2002 15:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262143AbSJNTvu>; Mon, 14 Oct 2002 15:51:50 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:32664 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S262141AbSJNTvs> convert rfc822-to-8bit; Mon, 14 Oct 2002 15:51:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bart De Schuymer <bart.de.schuymer@pandora.be>
To: coreteam@netfilter.org
Subject: [RFC] place to put bridge-netfilter specific data in the skbuff
Date: Mon, 14 Oct 2002 21:59:49 +0200
X-Mailer: KMail [version 1.4]
References: <20020911223252.GA12517@erik.ca> <200209120836.52062.bart.de.schuymer@pandora.be> <200210141953.38933.bart.de.schuymer@pandora.be>
In-Reply-To: <200210141953.38933.bart.de.schuymer@pandora.be>
Cc: linux-kernel@vger.kernel.org, Lennert Buytenhek <buytenh@gnu.org>,
       "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210142159.49290.bart.de.schuymer@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello netfilter team and others,

DaveM suggested I talk to you (netfilter team) about this.

What's bridge-netfilter: the mapping of the IPv4 onto the bridge hooks, to 
make a powerful bridging firewall.

The problem: in the current br-nf patch we add 3 fields to the skbuff, which 
is (as expected) not acceptable. So we need to find a way to solve this.

We cannot use the control buffer to save this data because tcp uses it while 
we still need the brnf data.

The solution I like best (and David seems to not mind) is adding one pointer 
to a struct nf_bridge_info in the skbuff. So, adding one new member.

Another suggestion by David is this:

struct nf_ct_info {
	union {
		struct nf_conntrack *master;
		struct nf_bridge_info *brinfo;
	} u;
};

But I don't think this will not work because master will be in use while we 
need brinfo.

So another solution could be this:

struct nf_ct_info {
		struct nf_conntrack *master;
		struct nf_bridge_info *brinfo;
};

But I don't know anything about the intricacies of adding this.

Do you have any other suggestions? Comments? Help?
The current patch was already posted on lkml so I won't repeat it.

Also, could you have a look at the current patch, to spot any other 
obstacles/things you don't like?
The patch is available at:
http://users.pandora.be/bart.de.schuymer/ebtables/br-nf/bridge-nf-0.0.10-dev-pre1-against-2.5.42.diff
There is a little text file explaining the source code more in-depth here:
http://users.pandora.be/bart.de.schuymer/ebtables/br-nf/bridge-nf-0.0.10-dev-pre1-against-2.5.39-comments.txt
A high-level explanation of what we're doing is here:
http://users.pandora.be/bart.de.schuymer/ebtables/br_fw_ia/br_fw_ia.html


Another question:
I've been told it is the general concensus that this bridge firewall should be 
compiled in the kernel if CONFIG_NETFILTER=y. Or should it be a user option? 
It is predicted that using a user option will give alot of questions about 
the bridge firewall not working.
Do you have any strong opinion about this?

-- 
cheers,
Bart

