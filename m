Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVIBTT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVIBTT6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVIBTT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:19:58 -0400
Received: from lead.cat.pdx.edu ([131.252.208.91]:721 "EHLO lead.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1750853AbVIBTT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:19:57 -0400
Message-ID: <1125688782.4318a5cea5dac@webmail.cecs.pdx.edu>
Date: Fri, 02 Sep 2005 12:19:42 -0700
From: tachades@cecs.pdx.edu
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.13 - space not freed to kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 32.97.110.142
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting tachades@cecs.pdx.edu:

> i have a program that all it does is to allocate memory up until consume 1GB
> of
> free resources. but when i delete it, it seemed that the space is not free to
> kernel, (notice this by looking at "top" or meminfo, as well as debug
> messages
> prinf the memory info. using sysinfo (system call). this happens on mainline
> kernel 2.6.13 but not on other Redhat distros (RHEL3/RHEL4).
>
> so it seemed that on mainline 2.6.13, when the userprocess allocate mem and
> free
> it mem, the freed memory is not returned back to the kernel... is this a
> possible bug????
>
> Please Observe this test program:
> Assumption: in main() the space (units in KB) to allocate is 1GB, if you
> machine
> has less than that use lower space value- 100MB (to be left to avoid oom
> killer).
> Idea: allocate using a linked list to as many nodes as it required to filled
> up
> 1GB or less of address space
>
> Result: on RHEL3 or 4, after the program allocate nodes, and then deallocate
> it,
> sysinfo indicate the memory that were freed are returned to the kernel.
> on 2.6.13, after the proram allocate nodes, and then deallocate it, sysinfo
> give
> the free{ram+swap} to be about the same as it was after the node finish
> allocating, seemed like the freed nodes address space were not returned to
> the
> kernel
>
> any ideaS?
>
>
> ****************SOURCE CODE *********************************
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <linux/sys.h>
> #include <linux/kernel.h>
> #include <sys/types.h>
> #include <sys/sysinfo.h>
>
>
>
> //////////////////////// CONST DATA ///////////////////////////////
> #define LIMIT 102400  /* = 100MB (Units in KB) */
> #define KB_VALUE 1024 /* Unit in bytes */
> #define ARR_SIZE 1024 /* array size for item data in node */
> ///////////////////////////////////////////////////////////////////
>
>
>
> /********************************************************************
> * Node Data Structure for LLL
> * size of this struct ~ 64 Bytes
> ********************************************************************/
> struct node
> {
>   int item[ARR_SIZE];
>   struct node * next;
> };
>
>
>
> ////////////////////////////// GLOBAL DATA ////////////////////////////
> struct node * head = NULL; /* head of LLL */
> long unsigned count_create = 0;
> long unsigned count_destroy= 0;
> ///////////////////////////////////////////////////////////////////////
>
>
>
> /**********************************************************************
> * Add a Node to LLL; data Uninitialized
> * Return: 1=succeed; 0=failed
> **********************************************************************/
> int
> lll_add()
> {
>   int i;
>   struct sysinfo si;
>
>   struct node *tmp = (struct node *)malloc(sizeof(struct node));
>   if(tmp == NULL) {
>     sysinfo(&si);
>     printf("freeram (%lu), freeswap (%lu), totalram (%lu), totalswap
> (%lu)\n",
>             si.freeram * si.mem_unit / KB_VALUE,
>             si.freeswap * si.mem_unit / KB_VALUE,
>             si.totalram * si.mem_unit / KB_VALUE,
>             si.totalswap * si.mem_unit / KB_VALUE);
>     fprintf(stderr,"ERROR: FAILED MALLOC\n");
>     return 0;
>     } else {
>       /* Write data here so space got from malloc is reserved */
>       ++count_create;
>       for(i = 0; i < ARR_SIZE; ++i)
>         tmp->item[i] = 0;
>         tmp->next= head;
>         head = tmp;
>         return 1;
>       }
>     }
>
>
>
> int
> lll_destroy_all()
> {
>    struct node * tmp = head;
>
>    while(tmp != NULL) {
>       head = tmp->next;
>       free(tmp);
>       ++count_destroy;
>       tmp = head;
>    }
>
>    return 1;
> }
>
>
>
> /**********************************************************************
> * Allocating nodes according to the input space specified
> * Assuming that input space is in KB, and free{ram+swap} > space +
> LIMIT (which is currently 100 MB)
> **********************************************************************/
> int
> lll_eat(long unsigned space)
> {
>   struct sysinfo si;
>   struct sysinfo si2;
>
>   sysinfo(&si);
>   sysinfo(&si2);
>
>   while( ((si.freeram * si.mem_unit / KB_VALUE) + (si.freeswap* si.mem_unit /
>            KB_VALUE) -
>           (si2.freeram* si2.mem_unit / KB_VALUE) - (si2.freeswap*
> si2.mem_unit /
>            KB_VALUE)) <=
>           (space)) {
>     if(lll_add() <= 0) {
>       perror("lll_add failed in lll_eat before done allocating specified
>               space\n");
>       return 0;
>     }
>
>     sysinfo(&si2);
>    }
>
>    sysinfo(&si2);
>    printf("After Done lll_eat.... \n");
>    printf("BEFORE : freeram (%lu), freeswap (%lu), totalram (%lu), totalswap
>           (%lu)\n", si.freeram * si.mem_unit / KB_VALUE, si.freeswap *
>           si.mem_unit / KB_VALUE,si.totalram * si.mem_unit / KB_VALUE,
>           si.totalswap * si.mem_unit / KB_VALUE);
>    printf("AFTER : freeram (%lu), freeswap (%lu), totalram (%lu), totalswap
>           (%lu)\n",si2.freeram * si2.mem_unit / KB_VALUE, si2.freeswap *
>           si2.mem_unit / KB_VALUE, si2.totalram * si2.mem_unit / KB_VALUE,
>           si2.totalswap * si2.mem_unit / KB_VALUE);
>    return 1;
> }
>
>
>
> int
> main(int argc, char ** argv)
> {
>   int status;
>   int path;
>   pid_t spid;
>
>   struct sysinfo si;
>   long unsigned space = 1048576; // alloc 1 GB (unit here in KB)
>
>   ///////////////////////////// DEBUGGING /////////////////////////////
>   sysinfo(&si);
>   printf("Before a.out parent (pid=%d) start.... \n", getpid());
>   printf("freeram (%lu), freeswap (%lu), totalram (%lu), totalswap (%lu)\n",
>           si.freeram * si.mem_unit / KB_VALUE,
>           si.freeswap * si.mem_unit / KB_VALUE,
>           si.totalram * si.mem_unit / KB_VALUE,
>           si.totalswap * si.mem_unit / KB_VALUE);
>   //////////////////////////////////////////////////////////////////////////
>
>
>   if(!lll_eat(space)) {
>     perror("Fail lll_eat\n");
>     exit(1);
>   }
>
>   printf("Done eating... Now Destroying\n");
>   sleep(5);
>
>   lll_destroy_all();
>
>   printf("Done destroying...\n");
>
>   printf("Created= %lu nodes, Destroyed= %lu nodes\n", count_create,
>           count_destroy);
>
>   ////////////////////////// DEBUGGING //////////////////////////////////
>   sysinfo(&si);
>   printf("After a.out parent exiting.... \n");
>   printf("freeram (%lu), freeswap (%lu), totalram (%lu), totalswap (%lu)\n",
>           si.freeram * si.mem_unit / KB_VALUE,
>           si.freeswap * si.mem_unit / KB_VALUE,
>           si.totalram * si.mem_unit / KB_VALUE,
>           si.totalswap * si.mem_unit / KB_VALUE);
>   ////////////////////////////////////////////////////////////////////////
>
>   return 0;
> }
>



