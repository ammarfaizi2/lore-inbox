Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbTAOQij>; Wed, 15 Jan 2003 11:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbTAOQij>; Wed, 15 Jan 2003 11:38:39 -0500
Received: from unthought.net ([212.97.129.24]:43662 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S266682AbTAOQih>;
	Wed, 15 Jan 2003 11:38:37 -0500
Date: Wed, 15 Jan 2003 17:47:31 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: DervishD <raul@pleyades.net>
Cc: jw schultz <jw@pegasys.ws>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030115164731.GB8621@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	DervishD <raul@pleyades.net>, jw schultz <jw@pegasys.ws>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com> <87iswrzdf1.fsf@ceramic.fifi.org> <20030114220401.GB241@DervishD> <20030114230418.GB4603@doc.pdx.osdl.net> <20030114231141.GC4603@doc.pdx.osdl.net> <20030115044644.GA18608@mark.mielke.cc> <20030115082527.GA22689@pegasys.ws> <20030115114130.GD66@DervishD> <20030115131617.GA8621@unthought.net> <20030115162219.GB86@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030115162219.GB86@DervishD>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 05:22:19PM +0100, DervishD wrote:
>     Hi Jakob :)
> 
> > >     Really, I'm thinking seriously about not rewritting argv[0] at
> > > all. The problem is that may confuse the user when issuing 'ps' or
> > > looking at /proc :((
> > What about
> [...]
> 
>     Mmm, interesting idea. A simpler solution is just copy the needed
> argv0. In your example, about 500 bytes are wasted ;))) By using the
> needed size at argv0, we have the space needed.

The point of the program is to exec() it once again, but with a larger
argv[0].

So what happens is that if the program is not called with --very-magic,
then it will call itself, with the following changes:
1)  argv[0] is 512 bytes long (511 bytes usable)
2)  --very-magic is supplied

Change 512 to whatever the limit you need is.  But the program should
(well that was the idea at least) never reach later parts of main()
unless it has a 512 (or whatever) byte argv[0].

> 
>     If execv doesn't do any magic with the supplied argv array, then
> this should work.

Yep, that's what I though.  Can anyone shoot this down?  ;)

> 
> > For the same effect without the --very-magic argument, you could simply
> > do an "if (argc != 2 || strlen(argv[0]) != 511)" instead.
> 
>     No, because the len of argv[0] being 'my proggy' is 9, that is not
> 511 ;)) We cannot tell the allocated space, I'm afraid O:)

Ok, I commented it to try to explain what it was I really meant to
say...   ;)

int main(int argc, char **argv)
{
 /* Check the length of argv[0] - we wat to make sure that 512 bytes are
  * allocated */
 if (strlen(argv[0]) != 511) {

   /* argv[0] is shorter than 511 non-zero bytes, so we can't be sure
    * it's really allocated big enough.  Now build an argv[0] buffer the
    * size we want it to be */

   char argv0[512];
   memcpy(argv0, 'a', 511);
   argv0[511] = 0;
   char *const args[] = { argv0, 0 };

   /* Exec ourselves, with the new argv[0] supplied - this means, we
    * will actually just re-execute ourselves, but our new "self" will
    * have a bigger argv[0] - since it's filled with 511 'a' characters,
    * our initial if() statement will evaluate to false and we will
    * not enter this block again */

   execv(argv[0], args);

   /* never to return... Let's play it safe and make sure nothing bad
    * happens */
   perror("You're fscked... execv says"); abort();
 }

 /* Cool - argv[0] was big - let's put a meaningful name in there */

 strcpy(argv[0], "my proggy");

  /* your code here - argv[0] is now 512 bytes long - putting the short
   * string into it just above, doesn't change the allocation of course */

}

Can anyone point out a problem in the above? I'd be happy to see it shot
down, mainly because it's ugly - and I hate programs that mess with
argv[0].

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
