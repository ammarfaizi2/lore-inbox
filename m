Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSHJOcs>; Sat, 10 Aug 2002 10:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317003AbSHJOcs>; Sat, 10 Aug 2002 10:32:48 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:18702 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316971AbSHJOce>; Sat, 10 Aug 2002 10:32:34 -0400
Date: Sat, 10 Aug 2002 15:36:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/12] eyestrain relief
Message-ID: <20020810153617.A9413@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D5464A4.84FC2DF3@zip.com.au> <20020810121430.A6215@infradead.org> <20020810163608.A1258@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020810163608.A1258@mars.ravnborg.org>; from sam@ravnborg.org on Sat, Aug 10, 2002 at 04:36:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2002 at 04:36:08PM +0200, Sam Ravnborg wrote:
> On Sat, Aug 10, 2002 at 12:14:30PM +0100, Christoph Hellwig wrote:
> > 
> > *hint* *hint* mconfig doesn't let your eyes burn..
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/hch/mconfig/
> 
> Any plans to share parser.y with the rest of the world?
> It is missing in the tar-ball.

It's below.  Bonus points go to the one who submits the automake magic
to generated parser.tab.{c,h} on the fly.

/*
 * parser.y
 *
 * Copyright 1998, 1999 Michael Elizabeth Chastain, <mailto:mec@shout.net>.
 * Licensed under the Gnu Public License, Version 2.
 *
 * Parse the language defined in Documentation/kbuild/config-language.txt
 * in the Linux kernel source.
 *
 * Also parses the little language of defconfig and .config files.
 */

/*
 * Global parser state variables.
 */

%{
    #include <string.h>

    #include "mconfig.h"

    int				parser_magic_cookie;
    block_type *		parser_block_top;
    def_line_list_type *	parser_def_line_list;
    int				parser_error_count;
    int				parser_warning_count;
%}

/*
 * Union of all parser node types across all languages.
 */

%union
{
    struct void_tag *		value_void;
    const char *		value_input_point;

    lexeme_type			value_lexeme;
    atom_type *			value_atom;
    atom_list_type *		value_atom_list;
    word_type *			value_word;
    word_list_type *		value_word_list;
    prompt_type *		value_prompt;
    symbol_type *		value_symbol;
    choice_list_type *		value_choice_list;
    unset_list_type *		value_unset_list;

    expr_type *			value_expr;

    statement_type *		value_statement;
    block_type *		value_block;

    def_line_type *		value_def_line;
    def_line_list_type *	value_def_line_list;
}

/*
 * Grammar symbols to handle language type.
 */

%type	<value_void>		start
%type	<value_void>		init
%type	<value_void>		start_language

%token	<value_void>		COOKIE_CONFIG_LANGUAGE
%token	<value_void>		COOKIE_DEF_CONFIG
%token	<value_void>		COOKIE_HELP_TEXT

/*
 * Grammar symbols for Config Language.
 */

%type	<value_block>		block
%type	<value_block>		scoped_block

%token	<value_input_point>	SOURCE

%type	<value_statement>	statement

%token	<value_input_point>	MAINMENU_OPTION
%token	<value_input_point>	ENDMENU

%token	<value_input_point>	MAINMENU_NAME
%token	<value_input_point>	COMMENT
%token	<value_input_point>	TEXT

%token	<value_input_point>	UNSET

%token	<value_input_point>	ASK_BOOL
%token	<value_input_point>	ASK_HEX
%token	<value_input_point>	ASK_INT
%token	<value_input_point>	ASK_STRING
%token	<value_input_point>	ASK_TRISTATE

%token	<value_input_point>	DEF_BOOL
%token	<value_input_point>	DEF_HEX
%token	<value_input_point>	DEF_INT
%token	<value_input_point>	DEF_STRING
%token	<value_input_point>	DEF_TRISTATE

%token	<value_input_point>	DEP_BOOL
%token	<value_input_point>	DEP_MBOOL
%token	<value_input_point>	DEP_HEX
%token	<value_input_point>	DEP_INT
%token	<value_input_point>	DEP_STRING
%token	<value_input_point>	DEP_TRISTATE

%token	<value_input_point>	CHOICE
%token	<value_input_point>	NCHOICE

%token	<value_input_point>	IF
%token	<value_void>		THEN
%token	<value_void>		ELSE
%token	<value_void>		FI
%token	<value_void>		'['
%token	<value_void>		']'
%token	<value_void>		';'
%type	<value_void>		semi_or_nl

%type	<value_expr>		expr
%type	<value_expr>		expr_not
%type	<value_expr>		expr_and
%type	<value_expr>		expr_or
%type	<value_expr>		expr_predicate
%type	<value_expr>		expr_word
%token	<value_input_point>	'!'
%token	<value_input_point>	'='
%token	<value_void>		DASH_O
%token	<value_void>		DASH_A

%type	<value_choice_list>	choice_list
%type	<value_unset_list>	unset_list
%type	<value_prompt>		prompt
%type	<value_symbol>		symbol

%type	<value_word_list>	extra_word_list
%type	<value_word>		word
%type	<value_word>		word_dquote
%type	<value_atom_list>	atom_list
%type	<value_atom>		atom_literal
%type	<value_atom>		atom_variable
%token	<value_input_point>	'"'
%token	<value_input_point>	'$'
%token	<value_lexeme>		LEXEME

/*
 * Grammar symbols for defconfig files.
 */

%token	<value_lexeme>		ISNOTSET
%type	<value_def_line>	def_line
%type	<value_def_line_list>	def_line_list

/*
 * Grammar symbols for help text.
 */

%%

/*
 * The start symbol.
 *
 * This is a kludge.  The lexer gives me a cookie to indicate language type:
 *
 *   arch/$ARCH/Config.in, ordinary Config Language
 *   .config or defconfig file
 *   help text (?)
 *
 * I need this kludge for two reasons.  First, bison gets unhappy if I use
 * multiple parsers, because the lexer needs to see a single set of token
 * constants and single YYLVAL type.  Second, I like to re-use some of the
 * low-level constructs such as atoms, and separate parsers won't let me do
 * that.
 */

start: init start_language
{
}

/*
 * This symbol initializes the return state for each parse.
 */

init:
{
    parser_block_top     = NULL;
    parser_def_line_list = NULL;
    parser_error_count   = 0;
    parser_warning_count = 0;
}



/*
 * Start symbol for Config Language.
 * Wrap the top-level block in a menu if it isn't already one.
 * Reducing to this symbol copies the top block pointer to a global place.
 */

start_language: COOKIE_HELP_TEXT block
{
    /*
	prompt->value.ptr         = "Mconfig Help Menu";
	prompt->value.len         = 17;
     */
    parser_block_top = $2;
}


start_language: COOKIE_CONFIG_LANGUAGE block 
{
    if ( $2->first != NULL && $2->first->next == NULL && $2->first->verb == verb_MENU )
    {
	parser_block_top = $2;
    }
    else
    {
	prompt_type *             prompt;
	statement_type *          statement;

	prompt                    = grab_memory( sizeof(*prompt) );
	prompt->next              = NULL;
	prompt->value.ptr         = "Main Menu";
	prompt->value.len         = 9;

	statement                 = grab_memory( sizeof(*statement) );
	statement->next           = NULL;
	statement->verb           = verb_MENU;
	statement->sc_title       = prompt;
	statement->sc_condition   = NULL;
	statement->sc_block_left  = $2;
	statement->sc_block_right = NULL;

	parser_block_top          = grab_memory( sizeof(*parser_block_top) );
	parser_block_top->first   = statement;
	parser_block_top->last    = statement;
    }
}



/*
 * A block is a list of statements.
 */

block: scoped_block
{
    $$ = $1;
    /* scope_close( ); */
}

scoped_block:
{
    $$        = grab_memory( sizeof(*$$) );
    $$->first = NULL;
    $$->last  = NULL;
    /* scope_open( ); */
}

scoped_block: scoped_block statement
{
    $$ = $1;

    if ( $$->first == NULL )
	$$->first = $2;
    if ( $$->last != NULL )
	$$->last->next = $2;
    $$->last = $2;
}

scoped_block: scoped_block '\n'
{
    $$ = $1;
}



/*
 * The source command is special: it gets executed immediately.
 */

scoped_block: scoped_block SOURCE LEXEME '\n'
{
    char * name;
    const char * error_string;

    $$ = $1;

    name = grab_memory( strlen(argument.ds) + $3.piece.len + 1 );
    sprintf( name, "%s%.*s", argument.ds, $3.piece.len, $3.piece.ptr );

    if ( input_push_file( name, &error_string ) < 0 )
    {
	parser_error( error_string, $2 );
	YYABORT;
    }
}



/*
 * Menu block.
 */

statement: MAINMENU_OPTION word '\n' block ENDMENU '\n'
{
    if ( $2->literal.len < 0 )
	parser_error( "mainmenu_option argument must be literal", $1 );

    if ( $2->literal.len != 12
    ||   memcmp( $2->literal.ptr, "next_comment", 12 ) != 0 )
	parser_error( "mainmenu_option unknown argument %.*s", $1,
			$2->literal.len, $2->literal.ptr );

    if ( $4->first == NULL || $4->first->verb != verb_comment )
	parser_error( "mainmenu_option next_comment must be followed by comment", $1 );

    $$                 = grab_memory( sizeof(*$$) );
    $$->next           = NULL;
    $$->verb           = verb_MENU;
    $$->sc_title       = ($4->first != NULL) ? $4->first->sb_prompt : NULL;
    $$->sc_condition   = NULL;
    $$->sc_block_left  = $4;
    $$->sc_block_right = NULL;
}



/*
 * If statement.
 */

statement: IF '[' expr ']' semi_or_nl THEN block FI '\n'
{
    $$                 = grab_memory( sizeof(*$$) );
    $$->next           = NULL;
    $$->verb           = verb_IF;
    $$->sc_title       = NULL;
    $$->sc_condition   = $3;
    $$->sc_block_left  = $7;
    $$->sc_block_right = NULL;
}

statement: IF '[' expr ']' semi_or_nl THEN block ELSE block FI '\n'
{
    $$                 = grab_memory( sizeof(*$$) );
    $$->next           = NULL;
    $$->verb           = verb_IF;
    $$->sc_title       = NULL;
    $$->sc_condition   = $3;
    $$->sc_block_left  = $7;
    $$->sc_block_right = $9;

    /*
     * FIXME: take the intersection of definitions in $7 and $9
     * and define those for this statement.
     */
}

semi_or_nl: ';' | '\n'
{
    ;
}



/*
 * Simple text-like statements.
 */

statement: MAINMENU_NAME prompt extra_word_list '\n'
{
    if ( $3->first != NULL )
	parser_warning( "mainmenu_name command has extra arguments", $1 );

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_mainmenu_name;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = NULL;
    $$->sb_def_value = NULL;
    $$->sb_dep_list  = NULL;
}

statement: COMMENT prompt extra_word_list '\n'
{
    if ( $3->first != NULL )
	parser_warning( "comment command has extra arguments", $1 );

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_comment;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = NULL;
    $$->sb_def_value = NULL;
    $$->sb_dep_list  = NULL;
}

statement: TEXT prompt extra_word_list '\n'
{
    if ( $3->first != NULL )
	parser_warning( "text command has extra arguments", $1 );

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_text;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = NULL;
    $$->sb_def_value = NULL;
    $$->sb_dep_list  = NULL;
}



/*
 * The UNSET verb.  This is a hack used in arch/{alpha,mips}/config.in.
 * I could actually start ignoring this once I fully implement TANDV/TAODAQ.
 */

statement: UNSET unset_list '\n'
{
    $$                = grab_memory( sizeof(*$$) );
    $$->next          = NULL;
    $$->verb          = verb_unset;
    $$->su_unset_list = $2;
}



/*
 * Command lines: ASK_*.
 */

statement: ASK_BOOL prompt symbol extra_word_list '\n'
{
#ifndef STRICT_TYPES
    if ( $4->first != NULL )
	parser_warning( "bool command has extra arguments", $1 );
#endif

    if ( $3->type == type_unset )
	$3->type = type_bool;
#ifdef STRICT_TYPES
    else if ( $3->type != type_bool )
#else
    else if ( $3->type != type_bool && $3->type != type_nchoice_slave )
#endif
	parser_error( "bool command re-defines a non-bool symbol %.*s", $1,
			$3->name.len, $3->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_ask_bool;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = $3;
    $$->sb_def_value = NULL; /* ignore extra arguments even without STRICT_SYNTAX */
    $$->sb_dep_list  = NULL;
}

statement: ASK_HEX prompt symbol word extra_word_list '\n'
{
    if ( $5->first != NULL )
	parser_warning( "hex command has extra arguments", $1 );

    if ( $3->type == type_unset )
	$3->type = type_hex;
    else if ( $3->type != type_hex )
	parser_error( "hex command re-defines a non-hex symbol %.*s", $1,
		$3->name.len, $3->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_ask_hex;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = $3;
    $$->sb_def_value = $4;
    $$->sb_dep_list  = NULL;
}

statement: ASK_INT prompt symbol word extra_word_list '\n'
{
    if ( $5->first != NULL )
	parser_warning( "int command has extra arguments", $1 );

    if ( $3->type == type_unset )
	$3->type = type_int;
    else if ( $3->type != type_int )
        parser_error( "int command redefines %.*s", $1,
			$3->name.len, $3->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_ask_int;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = $3;
    $$->sb_def_value = $4;
    $$->sb_dep_list  = NULL;
}

/*
 * The string command has an optional default value.
 */

statement: ASK_STRING prompt symbol '\n'
{
    word_type *             word;

    parser_warning( "string command needs a default value", $1 );

    if ( $3->type == type_unset )
	$3->type = type_string;
    else if ( $3->type != type_string )
    	parser_error( "string command redefines %.*s", $1,
			$3->name.len, $3->name.ptr);

    word              = grab_memory( sizeof(*word) );
    word->next        = NULL;
    word->dquote      = 1;
    word->literal.ptr = "";
    word->literal.len = 0;
    word->atom_first  = NULL;

    $$                = grab_memory( sizeof(*$$) );
    $$->next          = NULL;
    $$->verb          = verb_ask_string;
    $$->sb_prompt     = $2;
    $$->sb_symbol     = $3;
    $$->sb_def_value  = word;
    $$->sb_dep_list   = NULL;
}

statement: ASK_STRING prompt symbol word extra_word_list '\n'
{
    if ( $5->first != NULL )
	parser_warning( "string command has extra arguments", $1 );

    if ( $3->type == type_unset )
	$3->type = type_string;
    else if ( $3->type != type_string )
    	parser_error( "string command redefines %.*s", $1,
			$3->name.len, $3->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_ask_string;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = $3;
    $$->sb_def_value = $4;
    $$->sb_dep_list  = NULL;
}

statement: ASK_TRISTATE prompt symbol extra_word_list '\n'
{
#ifndef STRICT_TYPES
    if ( $4->first != NULL )
	parser_warning( "tristate command has extra arguments", $1 );
#endif
    if ( $3->type == type_unset )
	$3->type = type_tristate;
#ifdef STRICT_TYPES
    else if ( $3->type != type_tristate )
#else
    else if ( $3->type != type_tristate && $3->type != type_bool )
#endif
	parser_error( "tristate command re-defines a non-tristate symbol %.*s", $1,
			$3->name.len, $3->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_ask_tristate;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = $3;
    $$->sb_def_value = NULL; /* ignore extra arguments even without STRICT_SYNTAX */
    $$->sb_dep_list  = NULL;
}



/*
 * Command lines: DEF_*.
 */

statement: DEF_BOOL symbol word extra_word_list '\n'
{
    if ( $4->first != NULL )
	parser_warning( "define_bool command has extra arguments", $1 );

    if ( $2->type == type_unset )
	$2->type = type_bool;
#ifdef STRICT_TYPES
    else if ( $2->type != type_bool )
#else
    else if ( $2->type != type_bool && $2->type != type_nchoice_slave && $2->type != type_tristate)
#endif
	parser_error( "define_bool command re-defines a non-bool symbol %.*s", $1,
			$2->name.len, $2->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_def_bool;
    $$->sb_prompt    = NULL;
    $$->sb_symbol    = $2;
    $$->sb_def_value = $3;
    $$->sb_dep_list  = NULL;
}

statement: DEF_HEX symbol word extra_word_list '\n'
{
    if ( $4->first != NULL )
	parser_warning( "define_hex command has extra arguments", $1 );

    if ( $2->type == type_unset )
	$2->type = type_hex;
    else if ( $2->type != type_hex )
    	parser_error( "define_hex command redefines %.*s", $1,
		$2->name.len, $2->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_def_hex;
    $$->sb_prompt    = NULL;
    $$->sb_symbol    = $2;
    $$->sb_def_value = $3;
    $$->sb_dep_list  = NULL;
}

statement: DEF_INT symbol word extra_word_list '\n'
{
    if ( $4->first != NULL )
	parser_warning( "define_int command has extra arguments", $1 );

    if ( $2->type == type_unset )
	$2->type = type_int;
    else if ( $2->type != type_int )
    	parser_error( "define_int command redefines %.*s", $1,
			$2->name.len, $2->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_def_int;
    $$->sb_prompt    = NULL;
    $$->sb_symbol    = $2;
    $$->sb_def_value = $3;
    $$->sb_dep_list  = NULL;
}

statement: DEF_STRING symbol word extra_word_list '\n'
{
    if ( $4->first != NULL )
	parser_warning( "define_string command has extra arguments", $1 );

    if ( $2->type == type_unset )
	$2->type = type_string;
    else if ( $2->type != type_string )
    	parser_error( "define_string command redefines %.*s", $1,
			$2->name.len, $2->name.ptr);

    $$                = grab_memory( sizeof(*$$) );
    $$->next          = NULL;
    $$->verb          = verb_def_string;
    $$->sb_prompt     = NULL;
    $$->sb_symbol     = $2;
    $$->sb_def_value  = $3;
    $$->sb_dep_list   = NULL;
}

statement: DEF_TRISTATE symbol word extra_word_list '\n'
{
    if ( $4->first != NULL )
	parser_warning( "define_tristate command has extra arguments", $1 );

    if ( $2->type == type_unset )
	$2->type = type_tristate;
    else if ( $2->type != type_tristate )
    	parser_error( "define_tristate command redefines %.*s", $1,
			$2->name.len, $2->name.ptr);

    $$                = grab_memory( sizeof(*$$) );
    $$->next          = NULL;
    $$->verb          = verb_def_tristate;
    $$->sb_prompt     = NULL;
    $$->sb_symbol     = $2;
    $$->sb_def_value  = $3;
    $$->sb_dep_list   = NULL;
}




/*
 * Command lines: DEP_*.
 */


statement: DEP_BOOL prompt symbol extra_word_list '\n'
{
    if ( $4->first == NULL )
	parser_warning( "dep_bool command has no dependency arguments", $1 );

    if ( $3->type == type_unset )
	$3->type = type_bool;
#ifdef STRICT_TYPES
    else if ( $3->type != type_bool )
#else
    else if ( $3->type != type_bool && $3->type != type_nchoice_slave)
#endif
	parser_error( "dep_bool command redefines %.*s", $1,
    			$3->name.len, $3->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_dep_bool;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = $3;
    $$->sb_def_value = NULL;
    $$->sb_dep_list  = $4;
}

statement: DEP_MBOOL prompt symbol extra_word_list '\n'
{
    if ( $4->first == NULL )
	parser_warning( "dep_mbool command has no dependency arguments", $1 );

    if ( $3->type == type_unset )
	$3->type = type_bool;
#ifdef STRICT_TYPES
    else if ( $3->type != type_bool )
#else
    else if ( $3->type != type_bool && $3->type != type_nchoice_slave)
#endif
	parser_error( "dep_mbool command redefines %.*s", $1,
			$3->name.len, $3->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_dep_mbool;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = $3;
    $$->sb_def_value = NULL;
    $$->sb_dep_list  = $4;
}

statement: DEP_HEX prompt symbol word extra_word_list '\n'
{
    if ( $5->first == NULL )
	parser_warning( "dep_hex command has no dependency arguments", $1 );

    if ( $3->type == type_unset )
	$3->type = type_hex;
    else if ( $3->type != type_hex )
	parser_error( "dep_hex command redefines %.*s", $1,
			$3->name.len, $3->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_dep_hex;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = $3;
    $$->sb_def_value = $4;
    $$->sb_dep_list  = $5;
}

statement: DEP_INT prompt symbol word extra_word_list '\n'
{
    if ( $5->first == NULL )
	parser_warning( "dep_int command has no dependency arguments", $1 );

    if ( $3->type == type_unset )
	$3->type = type_int;
    else if ( $3->type != type_int )
	parser_error( "dep_int command redefines %.*s", $1,
			$3->name.len, $3->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_dep_int;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = $3;
    $$->sb_def_value = $4;
    $$->sb_dep_list  = $5;
}

statement: DEP_STRING prompt symbol word extra_word_list '\n'
{
    if ( $5->first == NULL )
	parser_warning( "warning: dep_string command has no dependency arguments", $1 );

    if ( $3->type == type_unset )
	$3->type = type_string;
    else if ( $3->type != type_string )
	parser_error( "dep_string command redefines %.*s", $1,
			$3->name.len, $3->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_dep_string;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = $3;
    $$->sb_def_value = $4;
    $$->sb_dep_list  = $5;
}

statement: DEP_TRISTATE prompt symbol extra_word_list '\n'
{
    if ( $4->first == NULL )
	parser_warning( "dep_tristate command has no dependency arguments", $1 );

    if ( $3->type == type_unset )
	$3->type = type_tristate;
    else if ( $3->type != type_tristate )
	parser_error( "dep_tristate command redefines %.*s", $1,
			$3->name.len, $3->name.ptr);

    $$               = grab_memory( sizeof(*$$) );
    $$->next         = NULL;
    $$->verb         = verb_dep_tristate;
    $$->sb_prompt    = $2;
    $$->sb_symbol    = $3;
    $$->sb_def_value = NULL;
    $$->sb_dep_list  = $4;
}



/*
 * Choice list, classic style.
 * 
 * Example (from 2.3.25-pre2 arch/arm/onfig.in):
 *
 *   $1   choice
 *   $2   'ARM system type'
 *   $3   "Archimedes        CONFIG_ARCH_ARC \
 *         A5000             CONFIG_ARCH_A5K \
 *         RiscPC            CONFIG_ARCH_RPC \
 *         EBSA-110          CONFIG_ARCH_EBSA110 \
 *         Footbridge-based  CONFIG_FOOTBRIDGE"
 *   $4   RiscPC
 *
 * $2 goes into the statement node as is.
 * $3 gets parsed, by hand, into a ps-list.
 * $4 gets translated to a symbol while I am parsing $3.
 */

statement: CHOICE prompt word word extra_word_list '\n'
{
    choice_list_type * choice_list;	/* choice list for $3		*/
    char * choices;			/* choice string from $3	*/
    char * cursor;			/* scanner for choices		*/
    int choice_count  = 0;		/* count of $3			*/
    int default_index = -1;		/* index of $4 in $3		*/
    int match_exact   = 0;		/* match counter for $4		*/
    int match_partial = 0;		/* match counter for $4		*/

    if ( $5->first != NULL )
	parser_warning( "choice command has extra arguments", $1 );

    if ( $4->literal.len < 0 )
	parser_error( "choice command default value must be literal", $1 );

    if ( $3->literal.len < 0 )
	parser_error( "choice command choice-list must be literal", $1 );

    /*
     * Build a new prompt-symbol list.
     */

    choice_list               = grab_memory( sizeof(*choice_list) );
    choice_list->prompt_first = NULL;
    choice_list->prompt_last  = NULL;
    choice_list->symbol_first = NULL;
    choice_list->symbol_last  = NULL;

    /*
     * I need a private copy of the choice string for three reasons:
     *   (1) I need a null-terminated string, not a piece, for strtok
     *   (2) strtok likes to scribble on its input
     *   (3) I may not even *have* a piece (error case)
     */

    if ( $3->literal.len < 0 )
    {
	choices = grab_memory( 1 );
	choices [0] = '\0';
    }
    else
    {
	choices = grab_memory( $3->literal.len+1 );
	memcpy( choices, $3->literal.ptr, $3->literal.len );
	choices [$3->literal.len] = '\0';
    }

    /*
     * Scan off one pair at a time.
     */

    for ( cursor = choices; ; cursor = NULL )
    {
	const char  * ptr;
	prompt_type * prompt;
	symbol_type * symbol;

	/*
	 * Grab the prompt.
	 */

	ptr = strtok( cursor, " \n\t\f\v" );
	if ( ptr == NULL )
	    break;

	prompt            = grab_memory( sizeof(*prompt) );
	prompt->next      = NULL;
	prompt->value.ptr = ptr;
	prompt->value.len = strlen(ptr);

	/*
	 * Grab the symbol.
	 */

	ptr = strtok( NULL, " \n\t\f\v" );
	if ( ptr == NULL )
	{
	    parser_error( "choice list must have an even number of words", $1 );
	    break;
	}

	{
	    piece_type name;
	    name.ptr = ptr;
	    name.len = strlen(ptr);
	    symbol   = symbol_create( name );
	    /* scope_define( symbol ); */
	}

	/*
	 * Choice symbols need to have unique definitions (imagine
	 * someone doing define_bool on an unselected choice outside
	 * the choice list!)
	 */

	if ( symbol->type == type_unset )
	    symbol->type = type_nchoice_slave;
	else
	    parser_error( "choice command re-defines %.*s", $1,
	    			symbol->name.len, symbol->name.ptr);

	/*
	 * Append to choice_list.
	 */

	if ( choice_list->prompt_first == NULL )
	    choice_list->prompt_first = prompt;
	if ( choice_list->prompt_last != NULL )
	    choice_list->prompt_last->next = prompt;
	choice_list->prompt_last = prompt;

	if ( choice_list->symbol_first == NULL )
	    choice_list->symbol_first = symbol;
	if ( choice_list->symbol_last != NULL )
	    choice_list->symbol_last->next = symbol;
	choice_list->symbol_last = symbol;

	/*
	 * Translate default from a value to a symbol name.
	 * E.g., "RiscPC" -> CONFIG_ARCH_RPC
	 * What a *stupid* syntax!
	 */
	if ( $4->literal.len >= 0 && $4->literal.len <= prompt->value.len
	&&   memcmp( $4->literal.ptr, prompt->value.ptr, $4->literal.len ) == 0 )
	{
	    if ( $4->literal.len == prompt->value.len )
	    {
		if ( match_exact++ == 0 )
		    default_index = choice_count;
	    }
	    else
	    {
		if ( match_partial++ == 0 && match_exact == 0 )
		    default_index = choice_count;
	    }
	}

	choice_count++;

    }

    /*
     * Complain about zero-length choices.
     * They aren't useful, and handling them properly is annoying.
     */

    if ( choice_count == 0 )
	parser_error( "choice command has no symbols", $1 );

    /*
     * Complain about funky default values.
     */

    if ( match_exact > 1 || ( match_exact == 0 && match_partial > 1 ) )
	parser_error( "choice command default value matches multiple values", $1 );

    if ( match_exact == 0 && match_partial == 0 )
	parser_error( "choice command default value matches no values", $1 );

    /*
     * Cons up a node.
     */

    $$                   = grab_memory( sizeof(*$$) );
    $$->next             = NULL;
    $$->verb             = verb_nchoice;
    $$->sn_prompt        = $2;
    $$->sn_choice_list   = choice_list;
    $$->sn_choice_count  = choice_count;
    $$->sn_choice_index  = default_index;
    $$->sn_default_index = default_index;
}



/*
 * Here is a better syntax for choice lists:
 *
 *   NCHOICE prompt symdefault prompt symbol prompt symbol prompt symbol ...
 *
 * This is what the ARM processor choice would look like as an nchoice:
 *
 *   $1   nchoice
 *   $2   'ARM system type'
 *   $3   CONFIG_ARCH_RPC
 *   $4   'Archimedes'		CONFIG_ARCH_ARC		\
 *        'A5000'		CONFIG_ARCH_A5K		\
 *        'RiscPC'		CONFIG_ARCH_RPC		\
 *        'EBSA-110'		CONFIG_ARCH_EBSA110	\
 *        'Footbridge-based'	CONFIG_FOOTBRIDGE
 *
 * Note that this allows prompts to have spaces in them, which would make
 * x86 processor type a lot more readable.
 */

statement: NCHOICE prompt symbol choice_list '\n'
{
    symbol_type * symbol;
    int choice_count;
    int default_index;
 
    /* this is true ... */
    parser_warning( "nchoice command is not compatible with old interpreters", $1 );

    for ( symbol  = $4->symbol_first, choice_count = 0, default_index = -1;
	  symbol != NULL;
	  symbol  = symbol->next, ++choice_count )
    {
	if ( symbol->type == type_unset )
	    symbol->type = type_nchoice_slave;
	else
	    parser_error( "nchoice command re-defines %.*s", $1,
	    			symbol->name.len, symbol->name.ptr);

	if ( $3->name.len == symbol->name.len
	&&   memcmp( $3->name.ptr, symbol->name.ptr, symbol->name.len ) == 0 )
	{
	    default_index = choice_count;
	}
    }

    if ( choice_count == 0 )
	parser_error( "nchoice command has no symbols", $1 );

    if ( default_index == -1 )
	parser_error( "nchoice command has bad default symbol", $1 );

    $$                   = grab_memory( sizeof(*$$) );
    $$->next             = NULL;
    $$->verb             = verb_nchoice;
    $$->sn_prompt        = $2;
    $$->sn_choice_list   = $4;
    $$->sn_choice_count  = choice_count;
    $$->sn_choice_index	 = default_index;
    $$->sn_default_index = default_index;
}



/*
 * Expression.
 */

expr: expr_not
{
    $$ = $1;
}

expr_not: expr_or
{
    $$ = $1;
}

expr_not: '!' expr_not
{

    $$             = grab_memory( sizeof(*$$) );
    $$->op         = op_not;
    $$->word_left  = NULL;
    $$->word_right = NULL;
    $$->expr_left  = $2;
    $$->expr_right = NULL;
}

expr_or: expr_and
{
    $$ = $1;
}

expr_or: expr_or DASH_O expr_and
{
    $$             = grab_memory( sizeof(*$$) );
    $$->op         = op_or;
    $$->word_left  = NULL;
    $$->word_right = NULL;
    $$->expr_left  = $1;
    $$->expr_right = $3;
}

expr_and: expr_predicate
{
    $$ = $1;
}

expr_and: expr_and DASH_A expr_predicate
{
    $$             = grab_memory( sizeof(*$$) );
    $$->op         = op_and;
    $$->word_left  = NULL;
    $$->word_right = NULL;
    $$->expr_left  = $1;
    $$->expr_right = $3;
}

expr_predicate: expr_word
{
    $$ = $1;
}

expr_predicate: word '=' word
{
    if ( $1->literal.len >= 0 && $3->literal.len >= 0 )
	parser_warning( "operator '=' has two literal operands", $2 );

    $$             = grab_memory( sizeof(*$$) );
    $$->op         = op_equal;
    $$->word_left  = $1;
    $$->word_right = $3;
    $$->expr_left  = NULL;
    $$->expr_right = NULL;
}

expr_predicate: word '!' '=' word
{
    if ( $1->literal.len >= 0 && $4->literal.len >= 0 )
	parser_warning( "operator '!=' has two literal operands", $2 );

    $$             = grab_memory( sizeof(*$$) );
    $$->op         = op_not_equal;
    $$->word_left  = $1;
    $$->word_right = $4;
    $$->expr_left  = NULL;
    $$->expr_right = NULL;
}

expr_word: word
{
    parser_warning( "naked word in conditional expression", $1->input_point );

    $$             = grab_memory( sizeof(*$$) );
    $$->op         = op_word;
    $$->word_left  = $1;
    $$->word_right = NULL;
    $$->expr_left  = NULL;
    $$->expr_right = NULL;
}



/*
 * Choice list.
 */

choice_list:
{
    $$               = grab_memory( sizeof(*$$) );
    $$->prompt_first = NULL;
    $$->prompt_last  = NULL;
    $$->symbol_first = NULL;
    $$->symbol_last  = NULL;
}

choice_list: choice_list prompt symbol
{
    $$ = $1;

    if ( $$->prompt_first == NULL )
	$$->prompt_first = $2;
    if ( $$->prompt_last != NULL )
	$$->prompt_last->next = $2;
    $$->prompt_last = $2;

    if ( $$->symbol_first == NULL )
	$$->symbol_first = $3;
    if ( $$->symbol_last != NULL )
	$$->symbol_last->next = $3;
    $$->symbol_last = $3;
}



/*
 * Symbol list for unset.
 */

unset_list:
{
    $$               = grab_memory( sizeof(*$$) );
    $$->symbol_first = NULL;
    $$->symbol_last  = NULL;
}

unset_list: unset_list symbol
{
    $$ = $1;

    if ( $$->symbol_first == NULL )
	$$->symbol_first = $2;
    if ( $$->symbol_last != NULL )
	$$->symbol_last->next = $2;
    $$->symbol_last = $2;
}



/*
 * Prompt.
 */

prompt: LEXEME
{
    $$        = grab_memory( sizeof(*$$) );
    $$->next  = NULL;
    $$->value = $1.piece;
}

prompt: word_dquote
{
    if ( $1->literal.len < 0 )
	parser_error( "prompt must have literal value", $1->input_point );

    $$        = grab_memory( sizeof(*$$) );
    $$->next  = NULL;
    $$->value = $1->literal;
}



/*
 * Symbol.
 */

symbol: LEXEME
{
    if ( $1.squote )
    {
	char * buffer = grab_memory( $1.piece.len + 64 );
	sprintf( buffer, "'%.*s': symbol may not be quoted.",
	    $1.piece.len, $1.piece.ptr );
	parser_error( buffer, $1.piece.ptr );
    }

    if ( $1.piece.len < 7 || memcmp( $1.piece.ptr, "CONFIG_", 7 ) != 0 )
    {
	char * buffer = grab_memory( $1.piece.len + 64 );
	sprintf( buffer, "'%.*s': bad symbol name (must be CONFIG_*).",
	    $1.piece.len, $1.piece.ptr );
	parser_warning( buffer, $1.piece.ptr );
    }

    $$ = symbol_create( $1.piece );
    /* scope_define( $$ ); */
}



/*
 * An extra_word_list eats up extra words at the end of a command.
 * These values are not used (in fact I could just leak them away);
 *   but a non-empty extra_word_list warrants a warning.
 */

extra_word_list:
{
    $$        = grab_memory( sizeof(*$$) );
    $$->first = NULL;
    $$->last  = NULL;
}

extra_word_list: extra_word_list word
{
    $$ = $1;
    if ( $$->first == NULL )
	$$->first = $2;
    if ( $$->last != NULL )
	$$->last->next = $2;
    $$->last = $2;
}



/*
 * A word can be a single atom or a double-quoted list of atoms.  If every atom
 * in a word is literal, the word is literal, and I compute the literal value
 * here.  Note that some semantic constructs require literal values (such as
 * the SOURCE command).
 */

word: atom_literal
{
    $$              = grab_memory( sizeof(*$$) );
    $$->next        = NULL;
    $$->input_point = $1->lexeme.piece.ptr;
    $$->dquote      = 0;
    $$->literal     = $1->lexeme.piece;
    $$->atom_first  = NULL;
}

word: atom_variable
{
    $$              = grab_memory( sizeof(*$$) );
    $$->next        = NULL;
    $$->input_point = $1->lexeme.piece.ptr;
    $$->dquote      = 0;
    $$->literal.ptr = NULL;
    $$->literal.len = -1;
    $$->atom_first  = $1;
}

word: word_dquote
{
    $$ = $1;
}

word_dquote: '"' atom_list '"'
{
    $$              = grab_memory( sizeof(*$$) );
    $$->next        = NULL;
    $$->input_point = $1;
    $$->dquote      = 1;

    if ( ! $2->is_literal )
    {
	/* contains a variable word */
	$$->literal.ptr = NULL;
	$$->literal.len = -1;
	$$->atom_first  = $2->first;
    }
    else
    {
	const atom_type * atom;
	int size;
	char * ptr_value;
	char * ptr;

	/* calculate the size */
	for ( atom = $2->first, size = 0; atom != NULL; atom = atom->next )
	    size += atom->lexeme.piece.len;
    
	/* synthesize a value */
	ptr_value = grab_memory( size );
	for ( atom = $2->first, ptr = ptr_value; atom != NULL; atom = atom->next )
	{
	    memcpy( ptr, atom->lexeme.piece.ptr, atom->lexeme.piece.len );
	    ptr += atom->lexeme.piece.len;
	}

	$$->literal.ptr = ptr_value;
	$$->literal.len = size;
	$$->atom_first  = NULL;
    }
}



/*
 * An atom list is a list of atoms.  I track whether the list contains
 * any variable atoms.
 */

atom_list:
{
    $$             = grab_memory( sizeof(*$$) );
    $$->is_literal = 1;
    $$->first      = NULL;
    $$->last       = NULL;
}

atom_list: atom_list atom_literal
{
    $$ = $1;
    if ( $$->first == NULL )
	$$->first = $2;
    if ( $$->last != NULL )
	$$->last->next = $2;
    $$->last = $2;
}

atom_list: atom_list atom_variable
{
    $$ = $1;
    $$->is_literal = 0;
    if ( $$->first == NULL )
	$$->first = $2;
    if ( $$->last != NULL )
	$$->last->next = $2;
    $$->last = $2;
}



/*
 * An atom is either a lexeme or a $lexeme.
 * Lexemes come in two flavors: xxx or 'xxx yyy zzz ...'.
 */

atom_literal: LEXEME
{
    $$         = grab_memory( sizeof(*$$) );
    $$->next   = NULL;
    $$->lexeme = $1;
    $$->dollar = 0;
}

atom_variable: '$' LEXEME
{
    if ( $2.squote )
	parser_error( "$'...' not allowed.", $1 );

    /* yes, people have done this in the corpus! */
    if ( $2.piece.len == 4 && memcmp( $2.piece.ptr, "arch", 4 ) == 0 )
    {
	parser_warning( "'$arch' not supported in old interpreters; use '$ARCH' instead.", $1 );
    }

    $$         = grab_memory( sizeof(*$$) );
    $$->next   = NULL;
    $$->lexeme = $2;
    $$->dollar = 1;

    /* scope_use( $$->value ); */
}



/*
 * The little language in defconfig and .config files.
 * This is a very simple language with just two statements:
 *
 *    # CONFIG_FOO is not set
 *    CONFIG_BAR=word
 *
 * These values are the -old- values of the symbols.  The distinction between
 * -old- and -new- is still a little mystical.
 *
 * But all I have to do is parse.
 */

start_language: COOKIE_DEF_CONFIG def_line_list
{
    parser_def_line_list = $2;
}

def_line_list:
{
    $$        = grab_memory( sizeof(*$$) );
    $$->first = NULL;
    $$->last  = NULL;
}

def_line_list: def_line_list def_line
{
    $$ = $1;
    if ( $$->first == NULL )
	$$->first = $2;
    if ( $$->last != NULL )
	$$->last->next = $2;
    $$->last = $2;
}

def_line_list: def_line_list '\n'
{
    $$ = $1;
}

def_line: symbol '=' word '\n'
{
    if ( $3->literal.len < 0 )
	parser_error( "symbol value must be literal", $2 );

    $$         = grab_memory( sizeof(*$$) );
    $$->symbol = $1;
    $$->value  = $3->literal;
}

def_line: ISNOTSET '\n'
{
    if ( $1.piece.len < 7 || memcmp( $1.piece.ptr, "CONFIG_", 7 ) != 0 )
    {
	char * buffer = grab_memory( $1.piece.len + 64 );
	sprintf( buffer, "'%.*s': bad symbol name (must be CONFIG_*).",
	    $1.piece.len, $1.piece.ptr );
	parser_warning( buffer, $1.piece.ptr );
    }

    $$         = grab_memory( sizeof(*$$) );
    $$->symbol = symbol_create( $1.piece );
    $$->value  = piece_n;
}
