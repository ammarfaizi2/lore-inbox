Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130081AbRCGEid>; Tue, 6 Mar 2001 23:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130102AbRCGEiW>; Tue, 6 Mar 2001 23:38:22 -0500
Received: from mnh-1-12.mv.com ([207.22.10.44]:4109 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S130081AbRCGEiS>;
	Tue, 6 Mar 2001 23:38:18 -0500
Message-Id: <200103070548.AAA05633@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Rajagopal Ananthanarayanan <ananth@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel lock contention and scalability 
In-Reply-To: Your message of "Tue, 06 Mar 2001 18:55:47 PST."
             <3AA5A333.4DF8A096@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Mar 2001 00:48:39 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ananth@sgi.com said:
> Here it is:
> 	http://oss.sgi.com/projects/postwait/
> Check out the download section for a 2.4.0 patch. 

After having thought about this a bit more, I don't see why pw_post and 
pw_wait can't be implemented in userspace as:

int pw_post(uid_t uid)
{
	return(kill(uid, SIGHUP)) /* Or signal of the waiter's choice */
}

int pw_wait(struct timespec *t)
{
	return(nanosleep(t, t));
}

In the case of UML, there would be a uid field in its lock structure and the 
spin code would look like:

	lock->uid = getpid();
	pw_wait(NULL);

and the lock release code would be:

	pw_post(lock->uid);

Obviously, sending signals to processes from the outside could massively 
confuse matters, but I don't see that being a big problem, since I think you 
can do that now, and no one is complaining about it.

Is there anything that I'm missing?

				Jeff


