Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267340AbUHIXLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267340AbUHIXLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267339AbUHIXLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 19:11:40 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:50410 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267342AbUHIXJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 19:09:53 -0400
Message-ID: <41180443.9030900@comcast.net>
Date: Mon, 09 Aug 2004 19:09:55 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Bug zapper?  :)
References: <4117D98C.2030203@comcast.net> <200408100042.37159.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408100042.37159.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Denis Vlasenko wrote:
> On Monday 09 August 2004 23:07, John Richard Moser wrote:
> 

[...]

> 
> 
> The flaw is that you think that kernel folks don't review their code.
> However, if you see some bad code, by all means - send a patch.
> 

Oh, no; as I said, even heavily quality assurance audited code has maybe 
5 bugs per kloc.  Where do the mremap() and munmap() bugs come from? 
Obviously you guys don't get everything.

> Asking others to do large amount of work is not very popular on this list.
> Do something yourself first.

Just do it in passing; you don't have to put a sudden hard effort to do 
these things in.  It'd be nice, but a major undertaking.

What I'm suggesting isn't much though, is it really?  Consider the 
functions function (normal code, not necessarily kernel):

void get_food(char **a) {
*a = malloc(strlen(global_food) + 1);
strcpy(*a, global_food);
}

/*Set our food*/
int set_food(char *food) {
if (!food)
return -1; /*error*/
free(global_food); /*if NULL, nothing happens*/
global_food = malloc(strlen(food) + 1);
strcpy(global_food, food);
return 0;
}

You'll have to forgive the lack of formatting; thunderbird is mean about 
this :/

Anyhow, as you can see, these are quite simple.  Function names are 
self-eplanitory, as is the process.  Assumedly, these are fine.

Now, we could try another approach at this, below.

/* get_food(char **a)
* Gets the current food.
*
* INPUT:
*  - char **a
*    Pointer to a pointer for the outputted food.
* OUTPUT:
*  - Return
*    none.
*  - *a
*    Set to a copy of the current food.
* PROCESS:
*  - Set '*a' to a newly allocated block of memory containing a copy
*    of the current food (global_food)
* STATE CHANGE:
*  none.
*/
void get_food(char **a) {
*a = malloc(strlen(global_food) + 1);
strcpy(*a, global_food);
}

/* set_food(char *food)
* Sets the current food.
*
* INPUT:
*  - char *food
*    Pointer to an ASCIIZ string containing the new food
* OUTPUT:
*  - Return
*    -1 on error
*    0 on success
* PROCESS:
*  - If (food is NULL)
*    - return error (-1)
*  - If (food is not NULL)
*    - Free current food (global_food)
*    - Set current food (global_food) to a newly allocated block
*      of memory containing a copy of 'food'
* STATE CHANGE:
*  - current food (global_food) is set to 'food'
*  - Memory holding previous food is freed
*/
int set_food(char *food) {
if (!food)
return -1; /*error*/
free(global_food); /*if NULL, nothing happens*/
global_food = malloc(strlen(food) + 1);
strcpy(global_food, food);
return 0;
}


These comment blocks are *MUCH* more verbose.  They describe the process 
loosely, but do give enough information to allow understanding without 
questions.

The large amount of extra commentary is worth it, IMHO.
> --
> vda
> 
> 

-- 
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

