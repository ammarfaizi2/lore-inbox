Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTGGU2u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 16:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTGGU2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 16:28:50 -0400
Received: from mail.corest.com ([200.61.53.195]:26710 "EHLO sin.core-sdi.com")
	by vger.kernel.org with ESMTP id S264147AbTGGU2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 16:28:47 -0400
Message-ID: <3F09DC3F.1030502@corest.com>
Date: Mon, 07 Jul 2003 17:46:55 -0300
From: jp <jp@corest.com>
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: tcp_parse_options() reading one byte off the packet limit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
tcp_parse_options() reading one byte off the packet limit

[2.] Full description of the problem/report:
The tcp_parse_options() function from net/ipv4/tcp_input.c does not 
properly validate packet's end when reading the opsize of a variable 
length option:


void tcp_parse_options(struct sk_buff *skb, struct tcp_opt *tp, int estab)
{
    unsigned char *ptr;
    struct tcphdr *th = skb->h.th;
    int length=(th->doff*4)-sizeof(struct tcphdr);

    ptr = (unsigned char *)(th + 1);
    tp->saw_tstamp = 0;

    while(length>0) {
       int opcode=*ptr++;
       int opsize;

       switch (opcode) {
          case TCPOPT_EOL:
             return;
          case TCPOPT_NOP:  /* Ref: RFC 793 section 3.1 */
             length--;
             continue;
          default:
             opsize=*ptr++;                        /* XXX */


The line responsible of the problem is marked with a 'XXX' comment in 
the source code above.
Depending on the length of the packet received, opsize may be forced to 
be loaded with:
    a) one byte from packet's data
    b) skbuff's padding if there's no data in the packet
    c) skb_shinfo's first field if there's no data in the
       packet and no padding in the skbuff's data

After a short analysis of the problem, we think this is not exploitable 
from a security standpoint, as there is always information after 
skb->end (both in 2.2 and 2.4 kernels). Also, leaking information from 
the read byte seem's not possible because of the checks performed after 
reading opsize.


[3.] Keywords (i.e., modules, networking, kernel):
networking

[4.] Kernel version (from /proc/version):
Linux version 2.4.18-19.8.0 (bhcompile@stripples.devel.redhat.com) (gcc 
version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Thu Dec 12 05:39:29 
EST 2002

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)
N/A

[6.] A small shell script or example program which triggers the
      problem (if possible)
N/A

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
Linux vaiolator 2.4.18-19.8.0 #1 Thu Dec 12 05:39:29 EST 2002 i686 i686 
i386 GNU/Linux

Gnu C                  gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7) 
Copyright (C) 2002 Free Software Foundation, Inc. This is free software; 
see the source for copying conditions. There is NO warranty; not even 
for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12

[7.2.] Processor information (from /proc/cpuinfo):
N/A
[7.3.] Module information (from /proc/modules):
N/A
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
N/A
[7.5.] PCI information ('lspci -vvv' as root)
N/A
[7.6.] SCSI information (from /proc/scsi/scsi)
N/A
[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
N/A
[X.] Other notes, patches, fixes, workarounds:
N/A

Thank you.
-- 
Juan Pablo Martinez Kuhn
CORE SECURITY TECHNOLOGIES

A26D E507 60F5 1B2C C30C
20DE 8240 3E28 3A2C D89D

  Florida 141 - 2º cuerpo - 7º piso
  C1005AAC Buenos Aires - Argentina
  Tel/Fax: (54 11) 5032-CORE (2673)
  http://www.corest.com

