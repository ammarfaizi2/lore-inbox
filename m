Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285448AbRLYKVW>; Tue, 25 Dec 2001 05:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285449AbRLYKVN>; Tue, 25 Dec 2001 05:21:13 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:14853 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285448AbRLYKVA>;
	Tue, 25 Dec 2001 05:21:00 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: Jesper Juhl <jju@dif.dk>, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: [PATCH] console_loglevel broken on ia64 (and possibly other archs) 
In-Reply-To: Your message of "Mon, 24 Dec 2001 23:35:15 BST."
             <20011224233515.B3932@elf.ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Dec 2001 21:20:46 +1100
Message-ID: <388.1009275646@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2001 23:35:15 +0100, 
Pavel Machek <pavel@suse.cz> wrote:
>Jesper Juhl wrote
>
>> This patch fixes the console_loglevel variable(s) so that code that
>> assumes the variables occupy continuous storage does not break (and
>> overwrite other data).
>
>It seems to me you are adding feature? And unneeded one, also.

No, it is a bug fix.  The existing code in kernel/printk.c has

/* Keep together for sysctl support */
int console_loglevel = DEFAULT_CONSOLE_LOGLEVEL;
int default_message_loglevel = DEFAULT_MESSAGE_LOGLEVEL;
int minimum_console_loglevel = MINIMUM_CONSOLE_LOGLEVEL;
int default_console_loglevel = DEFAULT_CONSOLE_LOGLEVEL;

and hopes that gcc will keep those variables together.  The sysctl code
only addresses console_loglevel and assumes that the other three
variables are at the next addresses.  There is no requirement for gcc
to keep unrelated variables in the order they are defined, on i386 it
does, on ia64 it does not.  On ia64, doing
   echo 1 2 3 4 > /proc/sys/kernel/printk
changes console_loglevel then corrupts three random words, whatever
variables gcc put after console_loglevel are destroyed.

