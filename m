Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWFMKFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWFMKFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 06:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWFMKFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 06:05:39 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:34323 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750895AbWFMKFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 06:05:39 -0400
Message-ID: <448E8DE7.4080003@shadowen.org>
Date: Tue, 13 Jun 2006 11:05:27 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [SPARSEMEM] confusing uses of SPARSEM_EXTREME (try #2)
References: <448D1117.8010407@innova-card.com> <448D9577.3040903@shadowen.org>	 <cda58cb80606121021w22207ef6yf6dfcbf428b144c3@mail.gmail.com>	 <448DA530.7050604@shadowen.org> <cda58cb80606130134h4f74a4b8ndd977a89942c8933@mail.gmail.com>
In-Reply-To: <cda58cb80606130134h4f74a4b8ndd977a89942c8933@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Franck Bui-Huu wrote:
> 2006/6/12, Andy Whitcroft <apw@shadowen.org>:
> 
>> Franck Bui-Huu wrote:
>> > Hi Andy
>> >
>> > 2006/6/12, Andy Whitcroft <apw@shadowen.org>:
>> >
>> >>
>> >> In my mind the positive option is selecting for code supporting
>> EXTREME
>> >> so it seems to make sense to use that option.
>> >
>> >
>> > well I find it confusing because in my mind, something like this seems
>> > more logical.
>> >
>> > #ifndef CONFIG_SPARSEMEM_STATIC
>> > static struct mem_section *sparse_index_alloc(int nid)
>> > {
>> >        return alloc_bootmem_node(...);
>> > }
>> > #else
>> > static struct mem_section *sparse_index_alloc(int nid)
>> > {
>> >        /* nothing to do here, since it has been statically allocated */
>> >        return 0;
>> > }
>> > #endif
>>
>> But also in this case the code in the first stanza is only applicable to
>> SPARSEMEM EXTREME, therefore its also logical to say
>>
> 
> Well I don't think so. Please show me which part of this code is
> _only_ applicable to EXTREME.
> 
> The only thing that makes it applicable to EXTREME is not in the code
> but rather in the Kconfig script:
> 
>        config SPARSEMEM_EXTREME
>                def_bool y
>                depends on SPARSEMEM && !SPARSEMEM_STATIC
> 

I think you have missed the point of the code here.  There are two
SPARSEMEM variants; STATIC and EXTREME.  The key point is that STATIC
was the original and only variant.  EXTREME is a later variant.

In the static case the section map is defined as:

  struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]

Where the NR_SECTION_ROOTS is always 1 allowing greater code sharing
between the two modes.  This the the primary and default variant.

In the extreme case it is defined as:

  struct mem_section *mem_section[NR_SECTION_ROOTS]

The key difference is that in EXTREME the second level is not allocated
statically, they are allocated as sections are discovered and
initialised.  The sparse_index_alloc routine is a SPARSEMEM hook to give
 variants the oppotunity to prepare for an area of sections to be used.
The EXTREME variant is using this hook to allocate the second levels as
it goes thus only populating those it is using; which is its key feature.

If we look at the definition in question, this is describing this
relationship exactly.  If we have EXTREME variant turned on then use the
alloc_bootmem_node to init the section root, else use the default
behaviour from the default variant STATIC.

  #ifdef CONFIG_SPARSEMEM_EXTREME
  static struct mem_section *sparse_index_alloc(int nid)
  {
         return alloc_bootmem_node(...);
  }
  #else
  static struct mem_section *sparse_index_alloc(int nid)
  {
         return 0;
  }
  #endif

This would be even more clear should a third variant MAGIC be added
where we would have:

  #ifdef CONFIG_SPARSEMEM_MAGIC
  static struct mem_section *sparse_index_alloc(int nid)
  {
         return wave_wand();
  }
  #elif defined(CONFIG_SPARSEMEM_EXTREME)
  static struct mem_section *sparse_index_alloc(int nid)
  {
         return alloc_bootmem_node(...);
  }
  #else
  static struct mem_section *sparse_index_alloc(int nid)
  {
         return 0;
  }
  #endif

If this was changed to an #ifndef we would be talking about something like:

  #if !defined(SPARSEMEM_EXTREME) && !defined(SPARSEMEM_STATIC)
  ... magic case
  #elif !defined(SPARSMEM_MAGIC) && !defined(SPARSMEM_STATIC)
  ... extreme case
  #else
  ... default case
  #endif

I think we can agree this is not clearer.

-apw
