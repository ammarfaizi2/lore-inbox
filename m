Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289752AbSAWJwN>; Wed, 23 Jan 2002 04:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289757AbSAWJvy>; Wed, 23 Jan 2002 04:51:54 -0500
Received: from [216.223.235.2] ([216.223.235.2]:58503 "HELO
	inventor.gentoo.org") by vger.kernel.org with SMTP
	id <S289752AbSAWJvg>; Wed, 23 Jan 2002 04:51:36 -0500
Subject: Athlon/AGP issue update
From: Daniel Robbins <drobbins@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de, alan@redhat.com, Andrew Morton <akpm@zip.com.au>,
        davem@redhat.com, vherva@niksula.hut.fi,
        Linux Weekly News <lwn@lwn.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 23 Jan 2002 02:52:53 -0700
Message-Id: <1011779573.9368.40.camel@inventor.gentoo.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Sorry for the delay in getting this information out.  I'll post this
info on gentoo.org as soon as I have time and some sleep.  

Today, I had a conference call with Sean Cleveland and Wayne Meritsky of
AMD and Rik van Riel and William Lee Irwin of kernelhackerdom. Here is
what we know so far.  There *is* an Athlon/AGP issue.  This issue has
*not* been tied to a bug with the Athlon/Duron processors.  The initial
reports of an Athlon CPU bug were based on information that I received
from an NVIDIA employee; this information turned out to be incorrect. 
In all fairness, he simply misunderstood the technical details of this
issue and told me that it was due to a "Athlon CPU bug" rather than
saying that it was a "potential cache coherency interaction between
Athlon speculative writes and the GART".  A mistake and misundestanding
of the details, but his heart was in the right place.  He was trying to
get this problem out in the open so that it could be addressed by the
Linux community.

AMD's educated guess is that these Athlon/AGP stability problems have to
do with speculative writes by the CPU and how they can cause indavertent
trashing of AGP memory if pages are mapped with indiscretion by the OS
and drivers.  The following explanation from AMD describes the issue in
detail:

-- AMD explanation follows ---

This note documents a subtle problem that AMD has seen in the field.

The operating system has created a 4MB translation that has attribute
bits that allow it to be cacheable.  GART also contains translations to
part of the underlying physical memory of this 4MB translation.

This situation is fundamentally illegal because GART is non-coherent and
all translations that the processor could use to access the AGP memory
must, therefore, be non-cacheable.  Although we have seen no intentional
access to the AGP memory by the processor via the 4MB cacheable
translation we have seen legitimate, speculative, accesses performed by
the processor.

The problem that has been experienced is caused by a speculative store
instruction that is not ultimately executed.  The logical address of the
store is through the 4MB translation to physical memory also translated
by GART and used by the AGP processor.

The effect of the store is to write-allocate a cache line in the data
cache and fill that cache line with data from the underlying physical
memory. Because the line was write-allocated it is subsequently written
back to physical memory even though the bits have not been changed by
the processor.  This write-back occurs when the cache-line is
re-allocated based upon replacement policy and is far removed in time
from the point at which the bits were read.

Between the time of the read and the time of the write, the AGP
processor has modified the bits in physical memory and the bits in the
data cache are stale.  This is happens because GART, being non-coherent,
does not snoop the processor caches for modified data.

When the cache-line eviction occurs the stale data written to physical
memory has fatal side effects.

Our conclusion is that the operating system is creating coherency
problems within the system by creating cacheable translation to AGP
GART-mapped physical memory.

-- end of AMD explanation --

Best Regards,

-- 
Daniel Robbins                                  <drobbins@gentoo.org>
Chief Architect/President                       http://www.gentoo.org 
Gentoo Technologies, Inc.

