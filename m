Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280043AbRKDRa2>; Sun, 4 Nov 2001 12:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280037AbRKDRaT>; Sun, 4 Nov 2001 12:30:19 -0500
Received: from unthought.net ([212.97.129.24]:46808 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S281053AbRKDRaF>;
	Sun, 4 Nov 2001 12:30:05 -0500
Date: Sun, 4 Nov 2001 18:30:04 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org,
        Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104183004.D14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org,
	Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
	Tim Jansen <tim@tjansen.de>
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160Nyq-2ACgt6C@fmrl07.sul.t-online.com> <20011104163354.C14001@unthought.net> <20011104163110Z16629-26012+114@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20011104163110Z16629-26012+114@humbolt.nl.linux.org>; from phillips@bonn-fries.net on Sun, Nov 04, 2001 at 05:31:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 05:31:50PM +0100, Daniel Phillips wrote:
...
> While the basic idea is attractive for a number of reasons, there are more 
> than a few questions to answer.  Take a look at a typical proc function, 
> meminfo_read_proc for example.  Its active ingredient is basically a sprintf 
> function:
> 
>         len += sprintf(page+len,
>                 "MemTotal:     %8lu kB\n"
>                 "MemFree:      %8lu kB\n"
>                 "MemShared:    %8lu kB\n"
> 		...,
>                 K(i.totalram),
>                 K(i.freeram),
>                 K(i.sharedram),
> 		...);
> 
> What does the equivalent look like under your scheme?

Well, in my previous mail I gave a vague description of the "media" but
the actual semantics of the informaiton.

I *suppose* we would represent the above like:
( ("version", 1),
  ("totalram", 1123412),
  ("freeram",  1243),
  ("sharedram", 234) )

This would be encoded in some simple binary form. Let's not get hung up in
those details for now.

Your example was very simple, and my solution is simple too - a list of
key/value pairs.  But my scheme will allow for tree structures, longer
lists, etc. etc.  too.

The API would probably be something like (I have 45 seconds of thought behind
this API so don't consider this a final draft)

dp_list * itall = new_dp_list();
add_dp_key(itall, "version", new_dp_int(1));
add_dp_key(itall, "totalram", new_dp_int(i.totalram));
add_dp_key(itall, "freeram", new_dp_int(i.freeram));
add_dp_key(itall, "sharedram", new_dp_int(i.sharedram));
len += dp_commit(page+len, itall);


dp_list * new_dp_list(void) 
 Creates a new empty list

void add_dp_key(dp_list*, const char*, dp_element*)
 Creates a two-element list, filling in the two elements
 with a string and a value element of arbitrary type.
 This list is appended as the new last element in the
 list given as the first argument.

int dp_commit(char*, dp_list*)
 Will encode the list argument into the buffer given,
 and free the entire list.

---

Now I agree that this API hurts the eyes already now - it should
not require a myriad of small structures with pointers to everywhere
to be allocated and de-allocated.   I can do better than this,
trust me,  but I can't do that until tomorrow  ;)

>   Does it remain 
> localized in one proc routine, or does it get spread out over a few 
> locations, possibibly with a part of the specification outside the 
> kernel?  Do the titles end up in your dotfile?  How do you specify whatever 
> formatting is necessary to transform a dotfile into normal /proc output?  Is 
> this transformation handled in user space or the kernel?  How much library 
> support is needed?

Wherever you have a routine for filling out a proc file, you'd add a
routine for filling out the dot-proc file.

Simple.  Keeping the routines together makes it more likely that the
maintainers and occational hackers will keep the two fairly well in sync.

(remember - this scheme does not *require* anything to be in sync though)


The dot-proc file does not generate the normal proc output.  Let the pretty
printing happen as it does today - changing a semicolon anywhere near an
existing proc routine is going to break half a gazillion programs in userland
anyway.

The *only* library support you need is
1)  Parsing of the dot-proc files into structures convenient for the
    language at hand (C first).
2)  Handling of the resulting structures, eg. allocation and de-allocation,
    if this is at all necessary - it may not be...


I'm not pushing style-sheets into the kernel  :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
