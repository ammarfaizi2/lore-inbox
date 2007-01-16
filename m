Return-Path: <linux-kernel-owner+w=401wt.eu-S932177AbXAPBrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbXAPBrN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 20:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbXAPBrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 20:47:13 -0500
Received: from smtp.ono.com ([62.42.230.12]:52232 "EHLO resmaa01.ono.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932177AbXAPBrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 20:47:12 -0500
Date: Tue, 16 Jan 2007 02:47:10 +0100
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Problem with POSIX threads in latest kernel...
Message-ID: <20070116024710.7e94326c@werewolf-wl>
X-Mailer: Claws Mail 2.7.0cvs26 (GTK+ 2.10.-1208314016; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_UWy_eK9MAUiL6rHNrJ2kXHa
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_UWy_eK9MAUiL6rHNrJ2kXHa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi...

I run the (almost) latest -mm kernel (2.6.20-rc3-mm1), and see some strange behaviour
with POSIX threads (glibc-2.4).
I have downgraded my test to a simple textboox example for a SMP-safe spool
queue, it's just a circular queue with a mutex and a condition variable for in
and out. I have seen the same structure in several places.

Well, it just sometimes gets blocked. GDB says its stuck in pthread_wait().
I could swear it worked on previous kernels. It works as is on IRIX.
I will try to build an older kernel to test.
I takes a second to block it with something like while :; tst; done.

Any ideas ?

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.1 (Cooker) for i586
Linux 2.6.19-jam04 (gcc 4.1.2 20061110 (prerelease) (4.1.2-0.20061110.2mdv2007.1)) #0 SMP PREEMPT

--MP_UWy_eK9MAUiL6rHNrJ2kXHa
Content-Type: text/x-csrc; name=tst.c
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=tst.c

#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <pthread.h>

#define SIZE		16

int				jobs[SIZE];
int				in;
int				slots;
pthread_mutex_t	slots_mutex;
pthread_cond_t	slots_cond;
int				out;
int				items;
pthread_mutex_t	items_mutex;
pthread_cond_t	items_cond;

void put(int job);
void get(int* job);
void* prod(void* data);
void* cons(void* data);

int main(int argc,char** argv)
{
	pthread_t	prodid,consid;

	in =3D 0;
	slots =3D SIZE;
	pthread_mutex_init(&slots_mutex,0);
	pthread_cond_init(&slots_cond,0);
	out =3D 0;
	items =3D 0;
	pthread_mutex_init(&items_mutex,0);
	pthread_cond_init(&items_cond,0);

	pthread_setconcurrency(3);
	pthread_create(&prodid,0,prod,0);
	pthread_create(&consid,0,cons,0);

	pthread_join(prodid,0);
	pthread_join(consid,0);

	return 0;
}

void* prod(void* data)
{
	int	i;

	for (i=3D0; i<1000; i++)
	{
		if (!(i%100))
			printf("put %d\n",i);
		put(i);
	}
	put(-1);
	puts("prod done");

	return 0;
}

void* cons(void* data)
{
	int	i;
	do
	{
		get(&i);
		if (!(i%100))
			printf("got %d\n",i);
	}
	while (i>=3D0);
	puts("cons done");

	return 0;
}

void put(int job)
{
	pthread_mutex_lock(&slots_mutex);
		while (slots<=3D0)
			pthread_cond_wait(&slots_cond,&slots_mutex);
		jobs[in] =3D job;
		in++;
		in %=3D SIZE;
		slots--;
		items++;
	pthread_mutex_unlock(&slots_mutex);

	pthread_mutex_lock(&items_mutex);
		pthread_cond_signal(&items_cond);
	pthread_mutex_unlock(&items_mutex);
}

void get(int* job)
{
	pthread_mutex_lock(&items_mutex);
		while (items<=3D0)
			pthread_cond_wait(&items_cond,&items_mutex);
		*job =3D jobs[out];
		out++;
		out %=3D SIZE;
		items--;
		slots++;
	pthread_mutex_unlock(&items_mutex);

	pthread_mutex_lock(&slots_mutex);
		pthread_cond_signal(&slots_cond);
	pthread_mutex_unlock(&slots_mutex);
}


--MP_UWy_eK9MAUiL6rHNrJ2kXHa--
