Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291727AbSBNPwX>; Thu, 14 Feb 2002 10:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291720AbSBNPwG>; Thu, 14 Feb 2002 10:52:06 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:45459 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S291727AbSBNPvt>; Thu, 14 Feb 2002 10:51:49 -0500
Date: Thu, 14 Feb 2002 16:51:43 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Cc: drepper@redhat.com, torvalds@transmeta.com, dmccr@us.ibm.com
Subject: setuid/pthread interaction broken? 'clone_with_uid()?'
Message-ID: <20020214165143.A16601@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	torvalds@transmeta.com, dmccr@us.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a process first issues setuid() and then goes on to create threads,
those threads run under the setuid() uid - all is well. 

However,  once the first thread is created, only the thread calling setuid()
gets setuid in fact. All new threads continue to be created as root.

This behaviour exists under 2.2.18 with glibc 2.1.3 and under 2.4.17 with
glibc 2.2.5, and is shown using the brief program attached.

Is this by design? It appears that all threads created get the uid of the
thread manager process.

>From our standpoint as an application developer, this is nasty. It means
that we have to do everything that needs root before creating the first
thread. This behaviour is also highly non obvious. 

A fix would appear to need a 'clone with uid' syscall, other solutions will
probably cause race condition. 

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc

--KsGdsel6WgEHnImy
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="testcase.c"

#include <stdio.h>
#include <pthread.h>
#include <errno.h>

void die(const char *what)
{
	fprintf(stderr,"Exiting because of a fatal error %s: %s\n",
		what, strerror(errno));
	exit(1);
}


void *child(void *p)
{
	printf("This is child %d, pid: %d, uid: %d\n", 
	       (int) p, getpid(), getuid());
	return 0;
}


int main(int argc, char **argv)
{
	pthread_t tid1,tid2,tid3;
	void* ret;

	pthread_create(&tid1, 0, child, (void *)1); /* stevens did this too */

	printf("Current pid: %d, current uid: %d\n", getpid(), getuid());
	if(setuid(2000)<0)
		die("setting uid");
	printf("uid now: %d\n",getuid());



	pthread_create(&tid2, 0, child, (void *)2);
	pthread_create(&tid3, 0, child, (void *)3);
	pthread_join(tid1, &ret);
	pthread_join(tid2, &ret);
	pthread_join(tid3, &ret);
	printf("Exiting.\n");
}

--KsGdsel6WgEHnImy--
