Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVCVGp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVCVGp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 01:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVCVGms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 01:42:48 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:55813 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262280AbVCVGlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 01:41:20 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Adrian Bunk <bunk@stusta.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [PATCH] reduce inlined x86 memcpy by 2 bytes
Date: Tue, 22 Mar 2005 08:40:53 +0200
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matt Mackall <mpm@selenic.com>, vital@ilport.com.ua
References: <200503181121.42809.vda@port.imtp.ilyichevsk.odessa.ua> <20050320131737.GD4449@stusta.de>
In-Reply-To: <20050320131737.GD4449@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503220840.53411.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 March 2005 15:17, Adrian Bunk wrote:
> Hi Denis,
> 
> what do your benchmarks say about replacing the whole assembler code 
> with a
> 
>   #define __memcpy __builtin_memcpy

It generates call to out-of-line memcpy()
if count is non-constant.

# cat t.c
extern char *a, *b;
extern int n;

void f() {
    __builtin_memcpy(a,b,n);
}

void g() {
    __builtin_memcpy(a,b,24);
}
# gcc -S -O2 --omit-frame-pointer t.c
# cat t.s
        .file   "t.c"
        .text
        .p2align 2,,3
.globl f
        .type   f, @function
f:
        subl    $16, %esp
        pushl   n
        pushl   b
        pushl   a
        call    memcpy
        addl    $28, %esp
        ret
        .size   f, .-f
        .p2align 2,,3
.globl g
        .type   g, @function
g:
        pushl   %edi
        pushl   %esi
        movl    a, %edi
        movl    b, %esi
        cld
        movl    $6, %ecx
        rep
        movsl
        popl    %esi
        popl    %edi
        ret
        .size   g, .-g
        .section        .note.GNU-stack,"",@progbits
        .ident  "GCC: (GNU) 3.4.1"

Proving that it is slower than inline is left
as an excercise to the reader :)

Kernel one will be inlined always.
void h) { __memcpy(a,b,n);} is
        movl    n, %eax
        pushl   %edi
        movl    %eax, %ecx
        pushl   %esi
        movl    a, %edi
        movl    b, %esi
        shrl    $2, %ecx
#APP
        rep ; movsl
        movl %eax,%ecx
        andl $3,%ecx
        jz 1f
        rep ; movsb
        1:
#NO_APP
        popl    %esi
        popl    %edi
        ret
--
vda

