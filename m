Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314376AbSDRPjL>; Thu, 18 Apr 2002 11:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314377AbSDRPjK>; Thu, 18 Apr 2002 11:39:10 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:11529 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314376AbSDRPjJ>;
	Thu, 18 Apr 2002 11:39:09 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables 
In-Reply-To: Your message of "Thu, 18 Apr 2002 23:02:11 +1000."
             <15550.50131.489249.256007@nanango.paulus.ozlabs.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 19 Apr 2002 01:38:59 +1000
Message-ID: <3112.1019144339@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2002 23:02:11 +1000 (EST), 
Paul Mackerras <paulus@samba.org> wrote:
>We already sort the kernel exception table on PPC using an insertion
>sort.  We have chrp, pmac, prep sections as well as init, which is why
>we had to do that.

Good, I will pinch that code and use it on all architectures.

>BTW, do you have any valid examples of use of copy_to/from_user or
>get/put_user in an init section?

No, I was using those functions as an example.  The problem is
__ex_table, there is other code that uses __ex_table besides
copy_to_user.  It is quite legal for an arch setup routine to use a
.fixup/__ex_table wrapper around code that might fail on some platforms
and to have that setup routine marked __init.

For example, arm #defines get8_unaligned_check which uses __ex_table.
__get_qspan_pci_config in ppc also uses __ex_table.  Use of any of
these macros (and others) in an __init section will generate unsorted
tables.  One table has already broken because of out of order text
sections.  Other tables may be broken, depending on what __init code an
architecture uses.

The real nasty is that we do not know if the table is broken until an
exception table entry is used and we fail to find an entry because the
table is not sorted.  Some exception table entries will work, others
will not, but there is no mechanism to test if the table is valid, we
blindly assume that it is.  It is far safer to sort the tables at boot
time than to hope that they are always sorted.

