Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTFTAs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 20:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTFTAs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 20:48:59 -0400
Received: from fmr04.intel.com ([143.183.121.6]:30153 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262095AbTFTAs6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 20:48:58 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780E0409F9@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Robert Schweikert'" <Robert.Schweikert@abaqus.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'Robert Schweikert'" <rjschwei@abaqus.com>
Subject: RE: process stack question
Date: Thu, 19 Jun 2003 18:02:48 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Robert Schweikert [mailto:Robert.Schweikert@abaqus.com]
> 
> My thinking is that I should be able to get a hold of the process call
> stack and using the top of the stack I should have the name of the
> function/method I am in.

What about something like getting the value of the EIP at
that point (will require some assembly-fu, most probably) and 
calling the equivalent of:

$ addr2line -f -e my-program ADDR

#define _GNU_SOURCE
#include <stdio.h>

const char *program_name;

void some_function (void)
{
  int cnt = 0;
  unsigned long my_eip;
  char *command;
  
  for (cnt = 0; cnt < 10; cnt++) {
    printf ("%d ", cnt);
    fflush (stdout);
  }
  printf ("\n");
  asm volatile (
    "    call 2f               \n"
    "2:                        \n"
    "    pop %0                \n"
    : "=r" (my_eip));
  printf ("I am at 0x%lx\n", my_eip);
  asprintf (&command, "addr2line -f -e \"%s\" 0x%lx\n",
	    program_name, my_eip);
  system (command);
}

int main (int argc, char **argv) 
{
  program_name = argv[0];
  some_function();
  return 0;
}

Not the most elegant solution, but gives an idea. Surely you
can call the equivalent of addr2line by linking into libbfd.
YMMV.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
