Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266353AbTAONHZ>; Wed, 15 Jan 2003 08:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266354AbTAONHZ>; Wed, 15 Jan 2003 08:07:25 -0500
Received: from unthought.net ([212.97.129.24]:65164 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S266353AbTAONHY>;
	Wed, 15 Jan 2003 08:07:24 -0500
Date: Wed, 15 Jan 2003 14:16:17 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: DervishD <raul@pleyades.net>
Cc: jw schultz <jw@pegasys.ws>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030115131617.GA8621@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	DervishD <raul@pleyades.net>, jw schultz <jw@pegasys.ws>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com> <87iswrzdf1.fsf@ceramic.fifi.org> <20030114220401.GB241@DervishD> <20030114230418.GB4603@doc.pdx.osdl.net> <20030114231141.GC4603@doc.pdx.osdl.net> <20030115044644.GA18608@mark.mielke.cc> <20030115082527.GA22689@pegasys.ws> <20030115114130.GD66@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030115114130.GD66@DervishD>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 12:41:30PM +0100, DervishD wrote:
>     Hi JW :)
> 
> > > > right after your envp.  So, writing more info there would blow away
> > > > your stack.
> > > I can smell the next hack... memmove() the stack down to make room... :-)
> > No need.  You can memcpy the environment.  See setenv(3),
> > putenv(3) and related library routines.
> 
>     I'm afraid that the best solution, well, the one which involves
> less code and less problems (no need to relocate the environment or
> things like that) is to write to argv[0] a shorter string that the
> existing one, and overwrite with nulls the rest of arguments, just in
> case the stack layout is not what expected.
> 
>     Really, I'm thinking seriously about not rewritting argv[0] at
> all. The problem is that may confuse the user when issuing 'ps' or
> looking at /proc :((

What about

int main(int argc, char **argv) {
 if (argc != 2 || (argv == 2 && !strcmp(argv[1], "--very-magic"))) {
  char argv0[512];
  memcpy(argv0, 'a', 511);
  argv0[511] = 0;
  char *const args[] = { argv0, "--very-magic", 0 };
  execv(argv[0], args);
 }
 strcpy(argv[0], "my proggy");

 /* your code here */
}

This should ensure that you have 511 bytes of argv[0] storage available,
if I read the previous posts correctly.

For the same effect without the --very-magic argument, you could simply
do an "if (argc != 2 || strlen(argv[0]) != 511)" instead.

Am I smoking crack, or could the above work?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
