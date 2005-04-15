Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVDOTvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVDOTvt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 15:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVDOTvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 15:51:49 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:14702 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261591AbVDOTvi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 15:51:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JEtCr/Njrhd7orGHzodqo5dqRb+9ooaLVfV4oIefwNJ6i5UAsNb3iTd7Ac++fbDdkESSAfrYEqTooD13zmbeSJolPN/Qgg/s3taeOK86Z5wYCgZ4O/dF3V65YoGnBno2OnxtG2vgUq0Zk5VQ60jzxQdcFegNmFCSgjBYKFXtA84=
Message-ID: <e1e1d5f40504151251617def40@mail.gmail.com>
Date: Fri, 15 Apr 2005 12:51:38 -0700
From: Daniel Souza <thehazard@gmail.com>
Reply-To: Daniel Souza <thehazard@gmail.com>
To: Igor Shmukler <igor.shmukler@gmail.com>
Subject: Re: intercepting syscalls
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <6533c1c905041512411ec2a8db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6533c1c905041511041b846967@mail.gmail.com>
	 <1113588694.6694.75.camel@laptopd505.fenrus.org>
	 <6533c1c905041512411ec2a8db@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, you're an adult, and may know what you are trying to do. listen
to the LKML guys, it's not a good idea.

/* idt (used in sys_call_table detection) */
/* from SuckIT */
struct idtr {
       ushort  limit;
       ulong   base;
} __attribute__ ((packed));

struct idt {
       ushort  off1;
       ushort  sel;
       u_char   none, flags;
       ushort  off2;
} __attribute__ ((packed));

/* from SuckIT */
void *memmem(char *s1, int l1, char *s2, int l2)
{
       if (!l2)
               return s1;
       while (l1 >= l2)
       {
               l1--;
               if (!memcmp(s1,s2,l2))
                       return s1;
               s1++;
       }
       return(NULL);
}

/* from SuckIT */
ulong   get_sct(ulong ep, ulong *pos)
{
       #define SCLEN 512
       char code[SCLEN];
       char *p;
       ulong r;

       memcpy(&code, (void *)ep, SCLEN);
       p = (char *) memmem(code, SCLEN, "\xff\x14\x85", 3);
       if (!p)
               return 0;
       pos[0] = ep + ((p + 3) - code);
       r =  *(ulong *) (p + 3);
       p = (char *) memmem(p+3, SCLEN - (p-code) - 3, "\xff\x14\x85", 3);
       if (!p) return 0;
       pos[1] = ep + ((p + 3) - code);
       return r;
}

/* from SuckIT */
static u_long locate_sys_call_table(void)
{
       struct idtr idtr;
       struct idt idt80;
       ulong sctp[2];
       ulong old80, sct, offp;

       asm ("sidt %0" : "=m" (idtr));
       offp = idtr.base + (0x80 * sizeof(idt80));
       memcpy(&idt80, (void *)offp, sizeof(idt80));
       old80 = idt80.off1 | (idt80.off2 << 16);
       sct = get_sct(old80, sctp);
       return(sct);
}

to use...

       u_long sct_addr;

       sct_addr = locate_sys_call_table();
       if ( !sct_addr )
       {
               OSARO_DOLOG("cannot find sys_call_table. aborting.");
               return(EACCES);
       }
       sys_call_table = (void *)sct_addr;


-- 
# (perl -e "while (1) { print "\x90"; }") | dd of=/dev/evil
