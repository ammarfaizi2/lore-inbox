Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWITTeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWITTeV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWITTeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:34:20 -0400
Received: from opersys.com ([64.40.108.71]:5125 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932305AbWITTeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:34:19 -0400
Message-ID: <451199F4.3000006@opersys.com>
Date: Wed, 20 Sep 2006 15:43:48 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com> <451030A6.6040801@google.com> <45105B5E.9080107@opersys.com> <451141B1.40803@hitachi.com> <451178B0.9030205@opersys.com> <20060920180808.GI18646@redhat.com> <451186F2.3060702@google.com> <45118D63.8070604@opersys.com> <451194DA.40300@google.com>
In-Reply-To: <451194DA.40300@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Bligh wrote:
> Do we even need the filler padding? I thought we could insert kprobes
> at the beginning of any function without that ... it was only a
> requirement for mid-function (sometimes). If we copy the whole function,
> we don't even need that any more ...
> 
> if kprobes can do it, I don't see why djprobes can't ... after all, it
> just seems to use kprobes to insert a jump, AFAICS.

I guess I must not be explaining myself properly.

The padding is for one purpose and one purpose only: having
a know-to-be-good location at the beginning of the
uninstrumented function for later using djprobes on. Once
you've got that, then you can indeed copy the entire
function and do whatever you want *without* using djprobes
or kprobes, but using direct calls.

If you don't have the padding, then you might yourself in
a case where you're replacing bytes from multiple instructions
where something somewhere may have an IP within the replaced
range. And to get around that you have to pull a few magic
tricks *and* make a few assumptions. But if you replace a
5 bytes instruction (or the equivalent as in Hiramatsu-san's
proposla) with another 5 bytes instruction, none of that is
needed and djprobes can be used *today* to do that.

Using this, you've got an arguably non-existent penalty
for the function with the filler and a very fast jump to
the instrumented function. The best of both worlds
actually.

Let me know if I'm still not being clear.

Karim

