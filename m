Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268198AbTGNIaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 04:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267952AbTGNIaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 04:30:07 -0400
Received: from indyio.rz.uni-saarland.de ([134.96.7.3]:52391 "EHLO
	indyio.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S265870AbTGNIaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 04:30:00 -0400
From: Michael Bellion and Thomas Heinz <nf@hipac.org>
Reply-To: nf@hipac.org
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [RFC] High Performance Packet Classifiction for tc framework
Date: Mon, 14 Jul 2003 10:45:40 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307141045.40999.nf@hipac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

We are planning to port our HIPAC algorithm to the tc framework and we
ask you for some comments about several issues.

HIPAC is a novel packet classification framework which replaces the
common linear approach with a more advanced data structure
which offers highly efficient and locking friendly packet matching.

Currently, people using lots of filters suffer from a big performance
penalty. In contrast, HIPAC is able to handle thousands of filters
without much slowdown compared to having no filters at all.

There already exists one application of the HIPAC algorithm for the
netfilter framework: nf-hipac. Details about the project can be found
at our website http://www.hipac.org or our sourceforge project page at
http://www.sourceforge.net/projects/nf-hipac

Several performance tests of nf-hipac have been done so far (see our
website) and have proven our claims. So it would be great if tc users
could benefit from HIPAC too.

Certainly, we'd like to know first whether HIPAC makes sense for the
tc framework at all. From the nf-hipac worst case performance tests
we know that our algorithm should be faster in all cases as soon as
you have approx. 20 filters. Below 20 filters there is no difference
between nf-hipac and the iptables filter table.
So basically the question is: Are people using the tc framework with
lots of filters? Some numbers would be helpful.

Since we can only improve performance of u32 and fw filters it's also
interesting whether such rulesets typically consist of those filters
in the main.

The tc framework is very flexible with respect to where filters can be
attached. Unfortunately this cannot be mapped into one HIPAC data
structure. Our current design allows to attach filters anywhere but
only the filters attached to the top level qdisc would benefit from the
HIPAC algorithm. Would this be a noticeable restriction?


Here is a short overview of the main design goals:

- new qdisc for HIPAC which is basically a container for the filters;
  it can only be attached as top level qdisc
- new HIPAC classifier which supports all native nf-hipac matches
  (src/dst ip, proto, src/dst port, ttl, state, in_iface, icmp type,
  tcpflags, fragments) and additionally fwmark
- the HIPAC classifier can only be attached to the HIPAC qdisc and vice
  versa the HIPAC qdisc only accepts HIPAC classifiers
- the HIPAC qdisc consists of only one single class to which the "next"
  qdisc must be attached
- the HIPAC classifier can contain a number of existing classifiers
  (u32, fw, route, rsvp, tcindex) whereby the semantics is as follows:
  a HIPAC classifier matches if the native matches and also each of the
  embedded classifiers match; the returned tcf_result is the one from
  the final classifier (=> intermediate classifiers are reduced to a
  match)
- it is still possible to attach non-hipac classifiers to other qdiscs
  and classes


Regards,

+-----------------------+----------------------+
|   Michael Bellion     |     Thomas Heinz     |
| <mbellion@hipac.org>  |  <creatix@hipac.org> |
+-----------------------+----------------------+

