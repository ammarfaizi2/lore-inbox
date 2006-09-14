Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWINPhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWINPhq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWINPhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:37:46 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:45516 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750836AbWINPhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:37:45 -0400
Date: Thu, 14 Sep 2006 11:37:43 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 4/11] LTTng-core 0.5.108 : core
Message-ID: <20060914153743.GC29906@Krystal>
References: <20060914034308.GE2194@Krystal> <20060914140459.GA23823@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060914140459.GA23823@sergelap.austin.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 11:28:28 up 22 days, 12:37,  8 users,  load average: 0.15, 0.19, 0.22
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> Hi,
> 
> I'm wondering why this is safe:
> 
> you grab references to the object which may be deleted after
> you drop the transport_list_lock at the top of this block.  Since
> a later patch shows the unregister being called right before the
> owning module is unloaded, that seems awefuly dangerous.
> 
> Is there some other magic going on making this safe?
> 

The ltt_traces_sem mutex is intended to make this safe. However, the transport
separation patch, contributed recently, uses its own transport_list_lock, which
seems to be broken.

I will fix it by using ltt_traces_sem around :


        down(&ltt_traces_sem);
        list_for_each_entry(tran, &ltt_transport_list, node) {
                if (!strcmp(tran->name, trace_type)) {
                        transport = tran;
                        break;
                }
        }

        if (!transport) {
                err = EINVAL;
                printk(KERN_ERR "LTT : Transport %s is not present.\n", trace_type);
                goto trace_error;
        }

        if(!try_module_get(transport->owner)) {
                err = ENODEV;
                printk(KERN_ERR "LTT : Can't lock transport module.\n");
                goto trace_error;
        }
        up(&ltt_traces_sem);

And change the transport_list_lock for ltt_traces_sem everywhere else.

Thanks for spotting this bug,

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
