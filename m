Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVABEiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVABEiB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 23:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVABEiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 23:38:01 -0500
Received: from web41408.mail.yahoo.com ([66.218.93.74]:1655 "HELO
	web41408.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261243AbVABEhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 23:37:43 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=01C7idn1OlvmwWa1CnsS+P/P9bFrn3QFxFPcpz3j5aheIi/0P0OrZxqPjYV75Bbn/ywndBrjXfNv5L8PO5a6/mdinkn4X0ken2Z/Zy1DZ7MePYiHzuLdJRmekSIHoZ3IqnDEq4GFtTL8vn2f3FU6OW7v/URlhNSvY30tLsvVmtI=  ;
Message-ID: <20050102043741.9207.qmail@web41408.mail.yahoo.com>
Date: Sat, 1 Jan 2005 20:37:41 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: ip_fast_csum usage
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
          In linux kernel source code of IP layer i
found that calculation of IP header checksum requires
 ip_fast_csum function to be called with IP header as
unsigned char string parameter.
 I want to know what will happen if i replace that IP
header parameter with my own unsigned char *data
variable which is align to 4 octet boundry.

	iph->check = ip_fast_csum((unsigned char *) iph,
iph->ihl);

the ip_fast_csum defined in kernel source is as
static inline unsigned short ip_fast_csum(unsigned
char * iph,
					  unsigned int ihl)
{
	unsigned int sum;

	__asm__ __volatile__(
	    "movl (%1), %0	;\n"
	    "subl $4, %2	;\n"
	    "jbe 2f		;\n"
	    "addl 4(%1), %0	;\n"
	    "adcl 8(%1), %0	;\n"
	    "adcl 12(%1), %0	;\n"
"1:	    adcl 16(%1), %0	;\n"
	    "lea 4(%1), %1	;\n"
	    "decl %2		;\n"
	    "jne 1b		;\n"
	    "adcl $0, %0	;\n"
	    "movl %0, %2	;\n"
	    "shrl $16, %0	;\n"
	    "addw %w2, %w0	;\n"
	    "adcl $0, %0	;\n"
	    "notl %0		;\n"
"2:				;\n"
	/* Since the input registers which are loaded with
iph and ipl
	   are modified, we must also specify them as
outputs, or gcc
	   will assume they contain their original values. */
	: "=r" (sum), "=r" (iph), "=r" (ihl)
	: "1" (iph), "2" (ihl)
	: "memory");
	return(sum);
}

I am just experimenting with this function from kernel
module to check how it works?
Thanks in advance.
regards,
cranium.


		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 
