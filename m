Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWIVCGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWIVCGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWIVCGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:06:31 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:9864 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932203AbWIVCGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:06:30 -0400
Date: Thu, 21 Sep 2006 22:01:19 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
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
Subject: Re: [PATCH] Linux Kernel Markers 0.7 for 2.6.17 (with type checking!)
Message-ID: <20060922020119.GA28712@Krystal>
References: <20060921232024.GA16155@Krystal> <451331A1.3020601@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <451331A1.3020601@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 21:17:21 up 29 days, 22:26,  1 user,  load average: 0.12, 0.14, 0.15
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Mathieu Desnoyers wrote:
> >+#ifdef CONFIG_MARK_SYMBOL
> >+#define MARK_SYM(name) \
> >+	do { \
> >+		__label__ here; \
> >+		here: asm volatile \
> >+			(MARK_KPROBE_PREFIX#name " = %0" : : "m" (*&&here)); 
> >\
> >+	} while(0)
> >+#else 
> >+#define MARK_SYM(name)
> >+#endif
> 
> BTW, this won't work if you put the MARK_SYM in a loop which gcc 
> unrolls; you'll only get the mark in the last unrolled iteration 
> (because the symbol assignments will override each other).
> 
> Do make this work properly, you really need to put the mark entries into 
> a separate section, so that if gcc duplicates the code, you get 
> duplicated markers too.
> 

Good point, I will change it to :

#define MARK_SYM(name) \
        do { \
                __label__ here; \
                volatile static void *__mark_kprobe_##name \
                        asm (MARK_CALL_PREFIX#name) \
                        __attribute__((unused)) = &&here; \
here: \
                do { } while(0); \
        } while(0)

Which fixes the problem. Some tests showed me that the compiler does not unroll
an otherwise unrolled loop when this specific macro is called. (test done with
-funroll-all-loops).

Regards,

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
