Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbTDPPyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264528AbTDPPyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:54:50 -0400
Received: from watch.techsource.com ([209.208.48.130]:42655 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S264524AbTDPPyn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:54:43 -0400
Message-ID: <3E9D82D7.1080304@techsource.com>
Date: Wed, 16 Apr 2003 12:20:39 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Gerrit Huizenga <gh@us.ibm.com>, John Bradford <john@grabjohn.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-English user messages
References: <E195cDL-00013K-00@w-gerrit2>  <3E9D688F.5040204@techsource.com> <1050503867.28586.91.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

>On Mer, 2003-04-16 at 15:28, Timothy Miller wrote:
>
>>The point of this painfully off-topic rant is that messages being 
>>written in English are a disadvantage for no one since they all already 
>>know English.  The messages are also simple enough that anyone
>>
>
>Thats a hopeless simplification for non techies and for some techies.
>

I recognize that having internationalized messages would be an 
advantage.  The question is whether or not that advantage outweighs the 
disadvantage.

This shouldn't stop anyone from working on it, however.  My message 
compression work only shaves off about 64k, MAYBE, which compared to the 
rest of the kernel footprint is tiny.  What you get is a more complex 
printk, no lower-case letters, and a meager space savings.  Embedded 
users might like it, but they'll start out with less text to compress in 
the first place; those who stand to benefit the most are the ones who 
can benefit the least.  Oh, and the build process will take at least 
twice as long.  IF this can be implemented in a way that makes it 
entirely transparent, maybe a few people will use it, so my primary 
motivation for doing it is that I'm enjoying working on it.  :)

>>I personally have a list of every kernel message I could extract from 
>>the source code of 2.4.20, and I've examined a lot of them.  It's a lot 
>>like reading Dr. Seuss.  Although some of the words are long, the 
>>vocabulary is incredibly small.  A lot of text is abbreviations and 
>>acronyms that you wouldn't translate anyhow!
>>
>
>I would be interested in how you extracted them, since a tool that can
>do this is the relevant 99% of the discussion, whether its for building
>message explanations, translation, reducing messages for embedded...
>
I used 2.4.20.  I modified Rules.make.  The line which does the compile 
(line 60), I changed like this:

%.o: %.c
    $(CPP) $(CFLAGS) $(EXTRA_CFLAGS_nostdinc) -DKBUILD_BASENAME=$(subst 
$(comma),_,$(subst -,_,$(*F))) $(CFLAGS_$@) $< > $<.i ; \
    $(CC) $(CFLAGS) $(EXTRA_CFLAGS_nostdinc) -DKBUILD_BASENAME=$(subst 
$(comma),_,$(subst -,_,$(*F))) $(CFLAGS_$@) -c -o $@ $<


When I built the kernel, for every .o file, I also got a .c.i file.  I 
used a script to scan the tree for .i files.  This is the script:

#!/bin/sh

for i in `ls -A | grep .i$`
do
    if [ -f $i ]
    then
        /home/tim/tmp/prkex < $i
    fi
done

for i in `ls -A`
do
    if [ -d $i ]
    then
    P=`pwd`
    cd $i
    $0
    cd $P
    fi
done



And here's 'prkex', a horrible little extraction program that I hacked 
together rather abruptly.  It doesn't do anything cool like use yacc or 
regex.  It gets the printk format strings using a half-wit state 
machine.  I figure I can get away with posting it because it's shorter 
than a lot of patches I see.  :)



#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


/* This is implemented as a state-machine which parses the input for
   strings which match:
   printk("...", ...);
*/


/* This is to deal with backslash followed by octal.  Since I don't
   try to deal with that properly, it's kinda pointless to have this.
   oh well. */
int state_stack[10];
int top_state = 0;


#define STATE (state_stack[top_state])

char *printk_string = "printk";
char last_out = '\n';

/* When extracting words, \n is a separator.  We don't need redundant \n */
void output_char(char c)
{
    if (last_out == '\n' && c == '\n') return;
    last_out = c;
    putchar(c);
}


/* Find printk and look for everything in the format string.  Deal with
   concatenation of multiple partial strings and ignore anything outside
   of quotes (__FILE__, etc) until we hit , or ). */
void process_char(int c)
{
    switch (STATE) {
    case 5:   /* look for 'k' */
        if (c == printk_string[5]) {
            STATE = '(';
        } else {
            STATE = 0;
        }
        break;
    default:  /* Look for first 5 chars of 'printk' */
        if (STATE < 5) {
            if (c == printk_string[STATE]) {
                STATE++;
            } else {
                STATE = 0;
            }
        } else {
            STATE = 0;
        }
        break;
    case '(':  /* Look for ( */
        if (isspace(c)) return;
        if (c == '(') {
            STATE = '[';
        } else {
            STATE = 0;
        }
        break;
    case '[':  /* Look for " */
        if (isspace(c)) return;
        switch (c) {
        case 34:
            STATE = 34;
            break;
        case ')':
        case ',':
        case ';':
            output_char('\n');
            STATE = 0;
            break;
        default:
            /* default doesn't abort because we get __FILE__, etc. */
            output_char('\n');
            break;
        }
        break;
    case 34:    /* We're in a string */
        if (c == '\\') {
            top_state++;
            STATE = '\\';
            return;
        }
        if (c == 34) {
            STATE = '[';
            return;
        }
        output_char(c);
        break;
    case '\\':  /* partially deal with backslash. */
        if (state_stack[top_state-1] == 34) {
            switch (c) {
            case 'n':
                output_char('\n');
                break;
            case 't':
                output_char('\t');
                break;
            case '\n':
                break;
            default:
                output_char(c);
                break;
            }
        }
        top_state--;
        break;
    }
}       
       
           

int main(int argc, char *argv[])
{
    int c;
   
    state_stack[0] = 0;
   
    while (!feof(stdin)) {
        c = getchar();
        if (c != EOF) process_char(c);
    }
   
    return 0;
}


