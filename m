Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSE1Sl6>; Tue, 28 May 2002 14:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSE1Sl5>; Tue, 28 May 2002 14:41:57 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:11794 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316882AbSE1Sl4>;
	Tue, 28 May 2002 14:41:56 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205281839.g4SIdN6224133@saturn.cs.uml.edu>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
To: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 28 May 2002 14:39:23 -0400 (EDT)
Cc: mikpe@csd.uu.se (Mikael Pettersson), jamagallon@able.es (J.A. Magallon),
        acme@conectiva.com.br (Arnaldo Carvalho de Melo),
        miles@gnu.org (Miles Bader), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org (Lista Linux-Kernel)
In-Reply-To: <13519.1022598057@redhat.com> from "David Woodhouse" at May 28, 2002 04:00:57 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:
> mikpe@csd.uu.se said:

>> They do implement inline asm() nowadays, but alas not &&label and
>> computed gotos.
>
> The only places I've seen &&label used


In the kernel or elsewhere? It's certainly useful.
Here it's used to make up for 'case' not supporting
strings, avoiding a cascade of 'else if'.


///////////////////////////////////////////////////////////////////////

static const char *set_personality(void){
  char *s;
  size_t sl;
  char buf[16];
  personality_table_struct findme = { buf, NULL};
  personality_table_struct *found;
  static const personality_table_struct personality_table[] = {
  {"390",      &&case_390},
  {"aix",      &&case_aix},
  {"gnu",      &&case_gnu},
  {"hp",       &&case_hp},
  {"hpux",     &&case_hpux},
  {"irix",     &&case_irix},
  {"os390",    &&case_os390},
  {"s390",     &&case_s390},
  {"sco",      &&case_sco},
  {"sgi",      &&case_sgi},
  {"unknown",  &&case_unknown}
  };
  const int personality_table_count
    = sizeof(personality_table)/sizeof(personality_table_struct);

  personality = 0;
  s = getenv("CMD_ENV");
  if(!s || !*s) s="unknown";   /* "Do The Right Thing[tm]" */
  sl = strlen(s);
  if(sl > 15) return "Environment specified an unknown personality.";
  strncpy(buf, s, sl);
  buf[sl] = '\0';
  saved_personality_text = strdup(buf);

  found = bsearch(&findme, personality_table, personality_table_count,
      sizeof(personality_table_struct), compare_personality_table_structs
  );

  if(!found) return "Environment specified an unknown personality.";

  goto *(found->jump);    /* See gcc extension info.  :-)   */

  case_gnu:
    personality = PER_GOOD_o | PER_CUMUL_MARKED | PER_OLD_m;
    // other stuff...
    return NULL;

  case_unknown: /* defaults, but also check inferior environment variables */
    if(
      getenv("UNIX95")     /* Irix */
      || getenv("POSIXLY_CORRECT")  /* most gnu stuff */
      || (getenv("POSIX2") && !strcmp(getenv("POSIX2"), "on")) /* Unixware 7 */
    ) personality = PER_BROKEN_o;
    return NULL;

  case_aix:
     // blah, blah...
     return NULL;

  case_irix:
  case_sgi:
    s = getenv("_XPG");
    if(s && s[0]>'0' && s[0]<='9') personality = PER_BROKEN_o;
    else personality = PER_IRIX_l;
    return NULL;

  case_os390:  /* IBM's OS/390 OpenEdition on the S/390 mainframe */
  case_s390:
  case_390:
    personality = PER_390_j;
    return NULL;

  case_hp:
  case_hpux:
  case_sco:
    personality = PER_BROKEN_o;
    return NULL;
}


//////////////////////////////////////////////////////////////////
