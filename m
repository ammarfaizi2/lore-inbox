Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263430AbTC2PBT>; Sat, 29 Mar 2003 10:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263433AbTC2PBS>; Sat, 29 Mar 2003 10:01:18 -0500
Received: from ns.avalon.ru ([195.209.229.227]:38218 "EHLO smtp.avalon.ru")
	by vger.kernel.org with ESMTP id <S263430AbTC2PBS> convert rfc822-to-8bit;
	Sat, 29 Mar 2003 10:01:18 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: fixme: possibly bug in some sch_* qdiscs?
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Sat, 29 Mar 2003 18:12:12 +0300
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B384095@frodo.avalon.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fixme: possibly bug in some sch_* qdiscs?
Thread-Index: AcL2BZM+86EVewkGQc+3orAwc2LBoQ==
From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The matter of problem is:
Some qdiscs (e.g sch_prio) don't destory their filter lists, when
someone deletes qdisc from interface without explicit filter deleting
before:
# tc qdisc add dev eth0 root handle 1: prio
# tc filter add dev eth0 parent 1: pref 1 protocol ip u32 match icmp
type 8 0xff classid 1:1
# tc qdisc del dev eth0 root
As i see (fixme), last tc command forces rtnetlink code to call
tc_get_qdisc() from net/sched/sch_api.c, which in turn, calls
qdisc_destroy() from net/sched/sch_generic.c, which calls qdisc
operations'  reset(), then destroy(), then frees memory if needed.
Unfortunately prio_destroy() from net/sched/sch_prio.c code does not
implement (i start digging 2.4.18 code, then checked 2.4.20, then
2.5.66) explicit destroying its filter_list from private data, and losts
that pointer.
I think it causes memory leackage, when we repeating 'tc qdisc del'
operation without explicit 'tc filter del' operations. Next obvious
effect, that in turn cls_u32.o module does not decrement its usage
counter, but increment it on each 'tc filter add' command. And, at some
circumstances 'tc filter show' command shows a few filters, after I
added only one! (think it sees last filters from previous instances of
sch_prio)
Fortunately but only sch_cbq.c, sch_atm.c do their destroy() in the
right way...
Which kernel maintainer I need to contact with to fix that problem (if
it is the problem, of course ;)

Dmitry.
