Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWESF4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWESF4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 01:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWESF4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 01:56:19 -0400
Received: from web52603.mail.yahoo.com ([206.190.48.206]:6530 "HELO
	web52603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932235AbWESF4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 01:56:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Rwx+AK97iyZUX4S9lVwHu2FHUcn4J2j20mArgkGpP0BfEWEgSt8KyzPR6LK67V5MKrZi1kI7GmIL00FfRDBRJBlsChbz3cXOmMdoe98OBkLFfLoSfy4/9syOjVxoRGNodcUmJdSmASJ+USXYgjlUdx4icoUZyl6DOm6JCxFK2pw=  ;
Message-ID: <20060519055617.78212.qmail@web52603.mail.yahoo.com>
Date: Fri, 19 May 2006 15:56:17 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Multi-threaded Program & Strace Problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-536114255-1148018177=:77507"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-536114255-1148018177=:77507
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Execution hangs or stalls unpredictably.

To recreate the problem:
1. $ for seq `900`; do echo localhost >> hosts.txt;
done
2. $ gcc -l pthread -o tping tping.c (tping.c is
attached)
3. $ while true; do strace -f ./tping 300 hosts.txt >
/dev/null 2>&1; echo -n .; done
4. Observe that execution stops, hangs or slows down
(while the said process is in ptrace_stop, I think).

Of course, when not straced, all is well.
Understandably , a production code isn't going to be
straced, but still ...

I've seen this behaviour on x86 2.6.16.16, 2.6.17-rc4,
FC5, SUSE 10.1 etc. Is it normal?

I'm fairly confident that my code is bugfree :-). If
not advance apologies.

Thanks


	

	
		
____________________________________________________ 
On Yahoo!7 
360°: Your own space to share what you want with who you want! 
http://www.yahoo7.com.au/360
--0-536114255-1148018177=:77507
Content-Type: text/x-csrc; name="tping.c"
Content-Description: 2969797018-tping.c
Content-Disposition: inline; filename="tping.c"

/*
   tping.c

   A threaded ping tool. Makes use of OS provided ping tool.

   Copyright 2006 Srihari Vijayaraghavan
   Created on 12 May 2006
   Last modified on 19 May 2006
   Version 0.00

   Released under the terms of GPL2.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>

#define MAX_HOSTNAME_LEN 256
#define MAX_CMDLINE (MAX_HOSTNAME_LEN + 30)

FILE *HOSTS_FILE;
pthread_mutex_t hosts_file_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t console_mutex = PTHREAD_MUTEX_INITIALIZER;

/* perror() */
void perr(char *msg)
{
	perror(msg);
	exit(errno);
}

/* pthread_mutex_lock() */
void lock(pthread_mutex_t *mutex)
{
        if (pthread_mutex_lock(mutex))
                perr("pthread_mutex_lock()");
}

/* pthread_mutex_unlock() */
void unlock(pthread_mutex_t *mutex)
{
        if (pthread_mutex_unlock(mutex))
                perr("pthread_mutex_unlock()");
}


/* read one host per attempt. serialise using a mutex */
int get_a_hostname(FILE *F, char *hostname)
{
	int i;
	lock(&hosts_file_mutex);
	i = fscanf(F, "%s", hostname);
	unlock(&hosts_file_mutex);
	return i; /* could be EOF */
}

/* print ping failure message to stdout */
void print_ping_failure_msg(char *hostname)
{
	lock(&console_mutex);
	printf("Failed to ping %s\n", hostname);
	unlock(&console_mutex);
}

/* ping a given hostname */
int ping_host(char *hostname)
{
	char cmd[MAX_CMDLINE] = "ping -c1 ";
	strcat(cmd, hostname);
	strcat(cmd, " > /dev/null 2>&1");
	return system(cmd);
}

/* our thread */
void ping_pthread(FILE *F)
{
	char hostname[MAX_HOSTNAME_LEN];
	while (get_a_hostname(F, hostname) != EOF)
		if (ping_host(hostname))
			print_ping_failure_msg(hostname);
	pthread_exit(EXIT_SUCCESS);
}

int main(int argc, char **argv)
{
	long numthreads, i;
	pthread_t *ping_threads;
	
	/* usage info */
	if (argc != 3) {
		fprintf(stderr, "Usage: %s numthreads hostfname\n", *argv);
		exit(EXIT_FAILURE);
	}

	/* how many threads? */
	numthreads = strtol(argv[1], NULL, 10);
	if (numthreads == EINVAL || numthreads == ERANGE)
		perr("strtol()");
	if (!(ping_threads = malloc(numthreads * sizeof(pthread_t))))
		perr("malloc()");

	/* open the hosts file */
	if (!(HOSTS_FILE = fopen(argv[2], "r")))
		perr("fopen()");

	/* create the threads */
	for (i = 0; i < numthreads && !feof(HOSTS_FILE); i++)
		if (pthread_create(&ping_threads[i], NULL,
				       	(void *) &ping_pthread, HOSTS_FILE))
			perr("pthread_create()");

	/* join the threads */
	while (i--)
		if (pthread_join(ping_threads[i], NULL))
			perr("pthread_join()");

	/* time to quit */
	free(ping_threads);
	if (fclose(HOSTS_FILE))
		perr("fclose()");
	exit(EXIT_SUCCESS);
}

--0-536114255-1148018177=:77507--
