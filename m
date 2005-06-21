Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVFUNkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVFUNkG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVFUNgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:36:45 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20635 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261389AbVFUNWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:22:31 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: <cutaway@bellsouth.net>, "Jesper Juhl" <juhl-lkml@dif.dk>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] cleanup patches for strings
Date: Tue, 21 Jun 2005 16:20:31 +0300
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Domen Puncer" <domen@coderock.org>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost> <200506211402.48554.vda@ilport.com.ua> <004c01c57662$5eacc260$2800000a@pc365dualp2>
In-Reply-To: <004c01c57662$5eacc260$2800000a@pc365dualp2>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506211620.31655.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Um, prev one was using push %reg. My fault.
push $imm gives the same result:

# gcc -O2 -falign-loops=64 t.c
# ./a.out
Took 9291 CPU cycles Took 8068 CPU cycles
Took 9080 CPU cycles Took 8058 CPU cycles
Took 9134 CPU cycles Took 8061 CPU cycles
Took 9084 CPU cycles Took 8043 CPU cycles
Took 9084 CPU cycles Took 8043 CPU cycles
Took 9084 CPU cycles Took 8043 CPU cycles

The source:

#define rdtscl(low) asm volatile("rdtsc" : "=a" (low) : : "edx")

#define NL "\n"

#include <stdio.h>

int main() {
    int i,k,start,end;
    int v = 1234;

for(k=0; k<6; k++) {
    rdtscl(start);
    for(i=0; i<1000; i++) {
        asm(NL
        "       push    %0" NL
        "       pop     %%eax" NL
        "       push    %0" NL
        "       pop     %%eax" NL
        "       push    %0" NL
        "       pop     %%eax" NL
        "       push    %0" NL
        "       pop     %%eax" NL
        : /* outputs */
        : "m" (v) /* inputs */
        : "ax" /* clobbers */
        );
    }
    rdtscl(end);
    printf("Took %u CPU cycles ", end-start);

    rdtscl(start);
    for(i=0; i<1000; i++) {
        asm(NL
        "       push    $1234" NL
        "       pop     %%eax" NL
        "       push    $1234" NL
        "       pop     %%eax" NL
        "       push    $1234" NL
        "       pop     %%eax" NL
        "       push    $1234" NL
        "       pop     %%eax" NL
        : /* outputs */
        : /* inputs */
        : "ax" /* clobbers */
        );
    }
    rdtscl(end);
    printf("Took %u CPU cycles\n", end-start);
}
    return 0;
}
--
vda

