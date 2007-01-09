Return-Path: <linux-kernel-owner+w=401wt.eu-S932516AbXAIXV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbXAIXV7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbXAIXV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:21:59 -0500
Received: from tomts13.bellnexxia.net ([209.226.175.34]:51489 "EHLO
	tomts13-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932516AbXAIXV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:21:58 -0500
Date: Tue, 9 Jan 2007 18:21:55 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] local_t : Documentation - update
Message-ID: <20070109232155.GA25387@Krystal>
References: <20061221001545.GP28643@Krystal> <20061223093358.GF3960@ucw.cz> <20070109031446.GA29426@Krystal> <20070109224100.GB6555@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20070109224100.GB6555@elf.ucw.cz>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 18:20:22 up 139 days, 20:27,  6 users,  load average: 0.30, 0.35, 0.39
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek (pavel@ucw.cz) wrote:
> Hi!
> 
> AFAICT this fails to mention... Is local_t as big as int? As big as
> long? Or perhaps smaller because high bits may be needed for locking?
> 
> 									Pavel
> 

Hi Pavel,

Here is an update that adds the information you mentionned in this reply and the
one to Andrew. Thanks for the comments.

Mathieu


index dfeec94..bd854b3 100644
--- a/Documentation/local_ops.txt
+++ b/Documentation/local_ops.txt
@@ -22,6 +22,13 @@ require disabling interrupts to protect from interrupt handlers and it permits
 coherent counters in NMI handlers. It is especially useful for tracing purposes
 and for various performance monitoring counters.
 
+Local atomic operations only guarantee variable modification atomicity wrt the
+CPU which owns the data. Therefore, care must taken to make sure that only one
+CPU writes to the local_t data. This is done by using per cpu data and making
+sure that we modify it from within a preemption safe context. It is however
+permitted to read local_t data from any CPU : it will then appear to be written
+out of order wrt other memory writes on the owner CPU.
+
 
 * Implementation for a given architecture
 
@@ -31,6 +38,12 @@ i386 and x86_64) and any SMP sychronization barrier. If the architecture does
 not have a different behavior between SMP and UP, including asm-generic/local.h
 in your archtecture's local.h is sufficient.
 
+The local_t type is defined as an opaque signed long by embedding an
+atomic_long_t inside a structure. This is made so a cast from this type to a
+long fails. The definition looks like :
+
+typedef struct { atomic_long_t a; } local_t;
+
 
 * How to use local atomic operations
 
@@ -42,6 +55,8 @@ static DEFINE_PER_CPU(local_t, counters) = LOCAL_INIT(0);
 
 * Counting
 
+Counting is done on all the bits of a signed long.
+
 In preemptible context, use get_cpu_var() and put_cpu_var() around local atomic
 operations : it makes sure that preemption is disabled around write access to
 the per cpu variable. For instance :
-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
