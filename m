Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTEDVNB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 17:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTEDVMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 17:12:24 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:56850 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261767AbTEDVLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 17:11:49 -0400
Date: Sun, 4 May 2003 18:24:38 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] list.h: implement list_for_each_entry_safe
Message-ID: <20030504212438.GA14414@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030504075748.GD12549@conectiva.com.br> <1052052632.27465.0.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052052632.27465.0.camel@rth.ninka.net>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 04, 2003 at 05:50:32AM -0700, David S. Miller escreveu:
> On Sun, 2003-05-04 at 00:57, Arnaldo Carvalho de Melo wrote:
> > ChangeSet@1.1219, 2003-05-04 04:39:21-03:00, acme@conectiva.com.br
> >   o list.h: implement list_for_each_entry_safe
> 
> Exists already, there is even a _rcu version.

Huh? Where is that? :-)

There is list_for_each_entry and list_for_each_entry_rcu, but not
list_for_each_entry_safe nor, for that matter, list_for_each_entry_safe_rcu.

list_for_each_entry was introduced not so long ago by Rusty, AFAIK, so that we
can simplify traversing lists that before, with just list_for_each & _safe and
_rcu variations required that we use a struct list_head as the loop iteration
variable and have as well another variable of the type contained in the list,
like this:

struct llc_sap *llc_sap_find(u8 sap_value)
{
        struct llc_sap* sap = NULL;
        struct list_head *entry;

        list_for_each(entry, &llc_main_station.sap_list.list) {
                sap = list_entry(entry, struct llc_sap, node);
                if (sap->laddr.lsap == sap_value)
                        goto out;
        }
	sap = NULL;
out:
        return sap;
}

Using the _entry variation this can (and will) be converted to

struct llc_sap *llc_sap_find(u8 sap_value)
{
        struct llc_sap* sap;

        list_for_each_entry(sap, &llc_main_station.sap_list.list, node)
                if (sap->laddr.lsap == sap_value)
                        goto out;
	sap = NULL;
out:
        return sap;
}

But then we need (at least I need for IPX, maybe others) the _entry_safe (and
most likely, at least initially for completeness, the _entry_safe_rcu)
variations. This is what I'm submitting :)

- Arnaldo
